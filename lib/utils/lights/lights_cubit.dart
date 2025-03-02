
import 'package:flutter_bloc/flutter_bloc.dart';
import 'lights_state.dart';
import 'module.dart';

// part 'lights_state.dart';

class LightsCubit extends Cubit<LightsState> {
  LightsCubit(Module module) : super(LightsState(module: module));

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
    print(state.module.brightness);
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

  void updateTemperature(double temp) {
    emit(state.copyWith(
      module: state.module.copyWith(temperature: temp),
    ));
  }

  void updateConnectionStatus(bool isConnected) {
    emit(state.copyWith(
      module: state.module.copyWith(isConnected: isConnected),
    ));
  }
  void overwriteSelectedModules(List<int> newSelection) {
    print("new Selection: $newSelection");
    emit(state.copyWith(selectedModules: newSelection));
    // print("selected Modules: ${state.selectedModules}");
  }

  void updateSelectedModules(int section) {
    final Set<int> centerSection = {0, 1, 2, 3, 4};
    List<int> updatedSelections = List.from(state.selectedModules);

      // Get the current selection state
      bool isCenterTapped = centerSection.contains(section);
      bool isCenterSelected = state.selectedModules.any(centerSection.contains);

      if (isCenterTapped) {
        if (isCenterSelected) {
        updatedSelections.removeWhere(centerSection.contains); // Deselect all center sections
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
    print("Selected Modules: ${updatedSelections}");
    emit(state.copyWith(selectedModules: updatedSelections));
  }
  void saveState() {
    // for presets (low)
  }
  void writeBluetooth() {
    // use state.module.<var> and state.selectedAddresses to send off thingies to bluetooth
  }
}
