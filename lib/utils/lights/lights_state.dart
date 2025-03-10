import 'package:equatable/equatable.dart';
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

