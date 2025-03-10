import 'package:equatable/equatable.dart';
import 'package:illuden/assets/constants.dart';
import 'module.dart';

class LightsState extends Equatable {

  final Module module;
  final List<int> selectedSections;
  final List<int> selectedAddresses;
  LightsState({
    required this.module,
    this.selectedSections = const <int>[],
    this.selectedAddresses = const <int>[],
  });


  LightsState copyWith({
    Module? module, 
    List<int>? selectedSections,
    List<int>? selectedAddresses, 
  }) {
    return LightsState(
      module: module ?? this.module,
      selectedSections: selectedSections ?? List.from(this.selectedSections),
      selectedAddresses: selectedAddresses ?? List.from(this.selectedAddresses),
    );
  }
  void debugPrintState({bool printSelections = true, bool printLEDsState = true}) {
    if (printSelections) {
      debugPrintSelections();
    }
    if (printLEDsState) {
      debugPrintLEDsState();
    }
  }
  void debugPrintSelections() {
    print("Selections: ");
    print("  sections = $selectedSections");
    print("  addresses = $selectedAddresses");
    print("  hex =  ${selectedAddresses.map((e) => e.toRadixString(16)).toList()}");
  }
  void debugPrintLEDsState(){
    print("LEDModule State: {");
    print("  temperature: ${module.temperature}");
    print("  LEDs: ${module.LEDs}");
    print("  isON: ${module.isON}");
    print("  isRGBmode: ${module.isRGBmode}");
    print("  brightness: ${module.brightness}");
    print("}");
  }
  @override
  List<Object> get props => [module, selectedSections, selectedAddresses];
}

// Simple Light Presets
final taskLightPreset = LightsState(
  module: Module(
    temperature: 5000,
    LEDs: {
      '2700': 80,
      '5000': 80,
      '6500': 80,
      'RGB': [0, 0, 0],
    },
    isON: true,
    isRGBmode: false,
    brightness: 80,
  ),
  selectedSections: [0, 1, 2, 3, 4],
  selectedAddresses: [16, 17, 18, 19, 20],
);

final directionalLightPreset = LightsState(
  module: Module(
    temperature: 3000,
    LEDs: {
      '2700': 80,
      '5000': 80,
      '6500': 80,
      'RGB': [0, 0, 0],
    },
    isON: true,
    isRGBmode: false,
    brightness: 80,
  ),
  selectedSections: [7, 12],
  selectedAddresses: [27, 28, 29, 44, 45, 46, 47],
);

final moodLightPreset = LightsState(
  module: Module(
    temperature: 3000,
    LEDs: {
      '2700': 0,
      '5000': 80,
      '6500': 0,
      'RGB': [0, 0, 0],
    },
    isON: true,
    isRGBmode: false,
    brightness: 80,
  ),
  selectedSections: [15],
  selectedAddresses: [56, 57, 58, 59, 60],
);

final resetLightPreset = LightsState(
  module: Module(
    temperature: 5000,
    LEDs: {
      '2700': 2,
      '5000': 2,
      '6500': 2,
      'RGB': [0, 0, 0],
    },
    isON: true,
    isRGBmode: false,
    brightness: 2,
  ),
  selectedSections: Constants.allSections,
  selectedAddresses: Constants.allAddresses,
);
