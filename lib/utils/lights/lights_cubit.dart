import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/widgets/bluetooth/cubit/bluetooth_cubit.dart';
import 'lights_state.dart';
import 'module.dart';
import '../../assets/constants.dart';

class LightsCubit extends Cubit<LightsState> {
  final BluetoothCubit _bluetooth;
  Timer? _throttleTimer;
  static final _throttleDuration = Duration(milliseconds: Constants.throttleTimerDuration);
  bool _isThrottled = false;
  LightsCubit(Module module, this._bluetooth)
      : super(LightsState(module: module));

  void togglePower() {
    emit(state.copyWith(
      module: state.module.copyWith(isON: !state.module.isON),
    ));
    setWhiteLEDValues();
    print("isON: ${state.module.isON}");
  }

  // Maps desired brightness and temperature to LED intensities
  void setWhiteLEDValues() {

    // Half actual intensity for safety
    int brightness = state.module.brightness;
    int temperature = state.module.temperature;
    int i_low = 0;
    int i_mid = 0;
    int i_high = 0;
    int t_low = 0;
    int t_high = 0;

    if (state.module.isON) {
      
      // Determine the two closest temperature LEDs
      if (temperature <= 5000) {
        t_low = 2700;
        t_high = 5000;
      } else {
        t_low = 5000;
        t_high = 6500;
      }

      // Calculate brightness for each LED.
      if (temperature == 5000) {
        i_mid = brightness;
      } else if (temperature == 6500) {
        i_high = brightness;
      } else {
        double ratio = (temperature - t_low) / (t_high - temperature);

        if (temperature < 5000) {
          i_low = (brightness / (1 + ratio)).toInt();
          i_mid = ((brightness * ratio) / (1 + ratio)).toInt();
        } else {
          i_mid = (brightness / (1 + ratio)).toInt(); 
          i_high = ((brightness * ratio) / (1 + ratio)).toInt();
        }
      }
    }
    
    updateLED('2700', i_low);
    updateLED('5000', i_mid);
    updateLED('6500', i_high);

    writeBluetooth();

    print("LEDs set to: ${state.module.LEDs}");
  }

  void setBrightness(int brightness) {
    if (brightness < 0 || brightness > 100) return;
    emit(state.copyWith(
      module: state.module.copyWith(brightness: brightness),
    ));
    setWhiteLEDValues();
    print("brightness: ${state.module.brightness}");
  }

  void switchMode(bool isRGB) {
    emit(state.copyWith(
      module: state.module.copyWith(isRGBmode: isRGB),
    ));
    print("isRGBmode: ${state.module.isRGBmode}");
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
    print("temp: ${state.module.temperature}");
  }

  void updateConnectionStatus(bool isConnected) {
    emit(state.copyWith(
      module: state.module.copyWith(isConnected: isConnected),
    ));
  }

  void overwriteSelectedModules(List<int> newSelection) {
    print("new selection: $newSelection");
    emit(state.copyWith(selectedSections: newSelection));
    // print("selected Sections: ${state.selectedSections}");
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
    print("Emitting:\n "
        "sections = $updatedSelections\n"
        "addresses = $updatedAddresses \n"
        "hex: ${updatedAddresses.map((e) => e.toRadixString(16)).toList()}" // use this when converting to hex, currently left as int for debugging
        );

    emit(state.copyWith(
        selectedSections: updatedSelections,
        selectedAddresses: updatedAddresses));
  }
  void selectAll() {
      emit(state.copyWith(
        selectedSections: List<int>.from(Constants.allSections),
        selectedAddresses: sectionsToAddresses(Constants.allSections)));
  }

  void deselectAll() {
    emit(state.copyWith(
      selectedSections: [],
      selectedAddresses: sectionsToAddresses([])));
    print("Selected Addresses: ${state.selectedAddresses}");
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

  // Takes the current module state and write to bluetooth
  void writeBluetooth() {
    if (_isThrottled) {
      return;
    }
    _isThrottled = true;
    _throttleTimer = Timer(_throttleDuration, () {
      _isThrottled = false;
      List<int> selectedAddresses = state.selectedAddresses;
      Map<String, dynamic> ledValues = state.module.LEDs;
      print("LED Values: $ledValues");

      // call BluetoothCubit write function to perform identical write
      if (state.module.isON) {
        bool isRGB = state.module.isRGBmode;
        print("RGB: $isRGB");
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
}
