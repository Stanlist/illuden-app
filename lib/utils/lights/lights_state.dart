import 'package:equatable/equatable.dart';
import 'package:illuden/assets/constants.dart';
import 'module.dart';

class LightsState extends Equatable {

  final Module module;
  final List<int> selectedSections;
  final List<int> selectedAddresses;
  final bool isCircadian;
  LightsState({
    required this.module,
    this.selectedSections = const <int>[],
    this.selectedAddresses = const <int>[],
    this.isCircadian = false,
  });

  LightsState copyWith({
    Module? module, 
    List<int>? selectedSections,
    List<int>? selectedAddresses, 
    bool? isCircadian,
  }) {
    return LightsState(
      module: module ?? this.module,
      selectedSections: selectedSections ?? List.from(this.selectedSections),
      selectedAddresses: selectedAddresses ?? List.from(this.selectedAddresses),
      isCircadian: isCircadian ?? this.isCircadian,
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
    print("  isCircadian: $isCircadian");
    print("}");
  }
  @override
  List<Object> get props => [module, selectedSections, selectedAddresses, isCircadian];
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
  selectedAddresses: [0x1A, 0x1C, 0x20, 0x23, 0x38],
  isCircadian: false,
);

final directionalLightPreset = LightsState(
  module: Module(
    temperature: 3000,
    LEDs: {
      '2700': 0,
      '5000': 80,
      '6500': 80,
      'RGB': [0, 0, 0],
    },
    isON: true,
    isRGBmode: false,
    brightness: 80,
  ),
  selectedSections: [5, 10],
  selectedAddresses: [0x13, 0x16, 0x11, 0x18, 0x10, 0x3A, 0x3B],
  isCircadian: false,
);

final moodLightPreset = LightsState(
  module: Module(
    temperature: 3000,
    LEDs: {
      '2700': 10,
      '5000': 2,
      '6500': 0,
      'RGB': [0, 0, 0],
    },
    isON: true,
    isRGBmode: false,
    brightness: 10,
  ),
  selectedSections: Constants.allSections,
  selectedAddresses: Constants.allAddresses,
  isCircadian: false,
);

final resetLightPreset = LightsState(
  module: Module(
    temperature: 5000,
    LEDs: {
      '2700': 5,
      '5000': 5,
      '6500': 5,
      'RGB': [0, 0, 0],
    },
    isON: true,
    isRGBmode: false,
    brightness: 5,
  ),
  selectedSections: Constants.allSections,
  selectedAddresses: Constants.allAddresses,
  isCircadian: false,
);
