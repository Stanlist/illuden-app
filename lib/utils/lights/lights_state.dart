import 'package:equatable/equatable.dart';
import 'module.dart';

class LightsState extends Equatable {

  final Module module;
  final List<int> selectedModules;
  LightsState({required this.module, this.selectedModules = const []});

  LightsState copyWith({
      Module? module, 
      List<int>? selectedModules
    }) {
    return LightsState(
      module: module ?? this.module,
      selectedModules: selectedModules ?? this.selectedModules,
    );
  }
  void debugPrintState() {
    print("LEDModule State: {");
    print("  temperature: ${module.temperature}");
    print("  LEDs: ${module.LEDs}");
    print("  isON: ${module.isON}");
    print("  isRGBmode: ${module.isRGBmode}");
    print("  brightness: ${module.brightness}");
    print("}");
  }
  @override
  List<Object> get props => [module,selectedModules];
}

