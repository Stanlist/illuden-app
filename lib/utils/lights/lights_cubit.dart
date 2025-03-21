import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/widgets/bluetooth/cubit/bluetooth_cubit.dart';
import 'lights_state.dart';
import 'module.dart';
import 'package:illuden/assets/constants.dart';
import 'package:flutter/material.dart';

class LightsCubit extends Cubit<LightsState> {
  final BluetoothCubit _bluetooth;
  
  Timer? _throttleTimer;
  static final _throttleDuration =
      Duration(milliseconds: Constants.throttleTimerDuration);
  bool _isThrottled = false;

  Timer? _debounceTimer;
  static final _debounceDuration =
      Duration(milliseconds: Constants.debounceTimerDuration);

  LightsCubit(Module module, this._bluetooth)
      : super(LightsState(module: module));

  void togglePower() {
    emit(state.copyWith(
      module: state.module.copyWith(isON: !state.module.isON),
    ));
    setWhiteLEDValues();
  }

  // Maps desired brightness and temperature to LED intensities
  void setWhiteLEDValues() {
    int brightness = state.module.brightness;
    int temperature = state.module.temperature;
    int iLow = 0;
    int iMid = 0;
    int iHigh = 0;
    int tLow = 0;
    int tHigh = 0;

    if (state.module.isON) {
      // Determine the two closest temperature LEDs
      if (temperature <= 5000) {
        tLow = 2700;
        tHigh = 5000;
      } else {
        tLow = 5000;
        tHigh = 6500;
      }

      // Calculate brightness for each LED.
      if (temperature == 5000) {
        iMid = brightness;
      } else if (temperature == 6500) {
        iHigh = brightness;
      } else {
        double ratio = (temperature - tLow) / (tHigh - temperature);

        if (temperature < 5000) {
          iLow = (brightness / (1 + ratio)).toInt();
          iMid = ((brightness * ratio) / (1 + ratio)).toInt();
        } else {
          iMid = (brightness / (1 + ratio)).toInt(); 
          iHigh = ((brightness * ratio) / (1 + ratio)).toInt();
        }
      }
    }
    
    updateLED('2700', iLow);
    updateLED('5000', iMid);
    updateLED('6500', iHigh);
    writeBluetooth();
  }

  void setBrightness(int brightness) {
    if (brightness < 0 || brightness > 100) return;
    emit(state.copyWith(
      module: state.module.copyWith(brightness: brightness),
    ));
    setWhiteLEDValues();
  }

  void switchMode(bool isRGB) {
    emit(state.copyWith(
      module: state.module.copyWith(isRGBmode: isRGB),
    ));
  }

  void updateLED(String key, dynamic value) {
    final newLEDs = Map<String, dynamic>.from(state.module.LEDs);
    newLEDs[key] = value;
    state.module.LEDs = newLEDs;
    emit(state.copyWith(
      module: state.module.copyWith(LEDs: newLEDs),
    ));
  }

  void updateTemperature(int temp) {
    emit(state.copyWith(
      module: state.module.copyWith(temperature: temp),
    ));
    setWhiteLEDValues();
  }

  void updateRgb(Color color) {
    // Extracting RGB values from the Color object
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final updatedLEDs = Map<String, dynamic>.from(state.module.LEDs);
    updatedLEDs['RGB'] = [red, green, blue];

    emit(state.copyWith(module: state.module.copyWith(LEDs: updatedLEDs)));
    writeBluetooth();
  }

  void updateConnectionStatus(bool isConnected) {
    emit(state.copyWith(
      module: state.module.copyWith(isConnected: isConnected),
    ));
  }

  bool noSelectedModules() {
    return state.selectedSections.isEmpty;
  }

  bool isIndirectSelected() {
    return state.selectedSections.contains(15);
  }

  void toggleIndirect() {
    // Create a new list from the current selected sections.
    List<int> updatedSelections = List.from(state.selectedSections);

    // Check if indirect (15) is already selected.
    if (updatedSelections.contains(15)) {
      // Remove indirect if it's already selected.
      updatedSelections.remove(15);
    } else {
      // Otherwise, add indirect.
      updatedSelections.add(15);
    }

    // Update addresses based on the new selection.
    List<int> updatedAddresses = sectionsToAddresses(updatedSelections);

    // Emit the updated state.
    emit(state.copyWith(
      selectedSections: updatedSelections,
      selectedAddresses: updatedAddresses,
    ));
  }

  void updateSelectedModules(int section) {
    final Set<int> centerSection = {0, 1, 2, 3, 4};
    List<int> updatedSelections = List.from(state.selectedSections);

    // Get the current selection state
    bool isCenterTapped = centerSection.contains(section);
    bool isCenterSelected = state.selectedSections.any(centerSection.contains);

    if (isCenterTapped) {
      if (isCenterSelected) {
        updatedSelections.removeWhere(
            centerSection.contains); // Deselect all center sections
      } else {
        updatedSelections.addAll(centerSection); // Select all center sections
      }
    } else {
      // Toggle normal section selection
      if (updatedSelections.contains(section)) {
        updatedSelections.remove(section);
      } else {
        updatedSelections.add(section);
      }
    }
    List<int> updatedAddresses = sectionsToAddresses(updatedSelections);
    emit(state.copyWith(
        selectedSections: updatedSelections,
        selectedAddresses: updatedAddresses));
  }

  void selectAll() {
    emit(state.copyWith(
        selectedSections: List<int>.from(Constants.allSections),
        selectedAddresses: sectionsToAddresses(Constants.allSections)));
    // print("Emitting:\n "
    //     "sections = ${state.selectedSections}\n"
    //     "addresses = ${state.selectedAddresses} \n");
  }

  void deselectAll() {
    emit(state.copyWith(
      selectedSections: [],
      selectedAddresses: sectionsToAddresses([])));
  }

  List<int> sectionsToAddresses(List<int> sections) {
    List<int> selectedAddresses = [];

    for (int section in sections) {
      if (Constants.sectionMap.containsKey(section)) {
        selectedAddresses.addAll(Constants.sectionMap[section]!);
      }
    }
    return selectedAddresses;
  }

  void saveState() {
    // for presets (low)
  }

  // First disable any active LEDs, then apply the preset
  void applyPreset(LightsState presetState) {
    _bluetooth.write(
          3,
          Constants.allAddresses,
          0,
          0,
          0,
          0,
          0,
          0,
        );
    emit(presetState);
    writeBluetooth();
  }

  // Allows light to follow circadian rhythm preset
  Timer? _circadianTimer;

  void circadianPreset({bool toggle = true}) {
    int duration = 1;
    bool tempDeltaDir = true;
    int currTemp = state.module.temperature;
    
    if (toggle){
      emit(state.copyWith(isCircadian: !state.isCircadian)); 
    } else {
      emit(state.copyWith(isCircadian: false));
    }

    if (state.isCircadian) {
      selectAll();
      _circadianTimer = Timer.periodic(Duration(seconds: duration), (timer) {
        if (!state.isCircadian) {
          _circadianTimer?.cancel();
        }
        if (currTemp <= 2700) {
          tempDeltaDir = true;
        } else if (currTemp >= 6500) {
          tempDeltaDir = false;
        }
        currTemp += tempDeltaDir ? 100 : -100;
        updateTemperature(currTemp);
      });
    } else {
      // Cancel the timer if the toggle is off
      _circadianTimer?.cancel();
    }
  }

  void debounce(VoidCallback callback) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, callback);
  }

  void throttle(VoidCallback callback) {
    if (!_isThrottled) {
      _isThrottled = true;
      _throttleTimer = Timer(_throttleDuration, () {
        _isThrottled = false;
        callback();
      });
    }
  }

  // Available delay functions: debounce, throttle
  void writeBluetooth() {
    debounce(() {
      List<int> selectedAddresses = state.selectedAddresses;
      Map<String, dynamic> ledValues = state.module.LEDs;
      state.debugPrintState();

      // call BluetoothCubit write function to perform identical write
      if (state.module.isON) {
        bool isRGB = state.module.isRGBmode;
        _bluetooth.write(
          3,
          selectedAddresses,
          isRGB ? 0 : ledValues['2700'],
          isRGB ? 0 : ledValues['5000'],
          isRGB ? 0 : ledValues['6500'],
          isRGB ? ledValues['RGB'][0] : 0,
          isRGB ? ledValues['RGB'][1] : 0,
          isRGB ? ledValues['RGB'][2] : 0,
        );
      } else {
        // If module is off, turn off all LEDs
        _bluetooth.write(
          3,
          Constants.allAddresses,
          0,
          0,
          0,
          0,
          0,
          0,
        );
      }
    });
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _throttleTimer?.cancel();
    return super.close();
  }
}

