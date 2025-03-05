import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/widgets/bluetooth/cubit/bluetooth_cubit.dart';
import 'lights_state.dart';
import 'module.dart';
import '../../assets/constants.dart';

class LightsCubit extends Cubit<LightsState> {
  final BluetoothCubit _bluetooth;
  LightsCubit(Module module, this._bluetooth)
      : super(LightsState(module: module));

  void togglePower() {
    emit(state.copyWith(
      module: state.module.copyWith(isON: !state.module.isON),
    ));
    print("isON: ${state.module.isON}");
  }

  void setBrightness(int brightness) {
    if (brightness < 0 || brightness > 100) return;
    emit(state.copyWith(
      module: state.module.copyWith(brightness: brightness),
    ));
    print("brightness: ${state.module.brightness}");
  }

  void switchMode(bool isRGB) {
    emit(state.copyWith(
      module: state.module.copyWith(isRGBmode: isRGB),
    ));
  }

  void updateLED(String key, dynamic value) {
    final newLEDs = Map<String, dynamic>.from(state.module.LEDs);
    newLEDs[key] = value;
    emit(state.copyWith(
      module: state.module.copyWith(LEDs: newLEDs),
    ));
  }

  void updateTemperature(int temp) {
    emit(state.copyWith(
      module: state.module.copyWith(temperature: temp),
    ));
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
    emit(state.copyWith(selectedSections: []));
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
    List<int> selectedAddresses = state.selectedAddresses;
    Map<String, dynamic> ledValues = state.module.LEDs;

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
  }
}
