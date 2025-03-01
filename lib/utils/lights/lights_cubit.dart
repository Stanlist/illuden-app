
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
  }

  void setBrightness(int brightness) {
    if (brightness < 0 || brightness > 100) return;
    emit(state.copyWith(
      module: state.module.copyWith(brightness: brightness),
    ));
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
  void updateSelectedModules(List<int> selectedModules) {
    emit(state.copyWith(selectedModules: selectedModules));
    state.debugPrintState();
  }
}
