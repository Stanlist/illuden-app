import 'package:equatable/equatable.dart';

class Module extends Equatable {
  final String id;
  final String label;
  bool isOn;
  int brightness; // 0-100
  List<int> rgb; // RGB values
  double temperature; // Temperature value in Kelvin

  Module({
    required this.id,
    required this.label,
    this.isOn = false,
    this.brightness = 0,
    this.rgb = const [0, 0, 0],
    this.temperature = 2700.0,
  });

  // Method to update brightness or other parameters
  void updateBrightness(int newBrightness) {
    this.brightness = newBrightness;
  }

  void updateTemperature(double newTemperature) {
    this.temperature = newTemperature;
  }

  void updateRGB(List<int> newRGB) {
    this.rgb = newRGB;
  }

  // Convert the Module to a byte array for Bluetooth transmission
  List<int> toByteArray() {
    List<int> byteArray = [];
    byteArray.add(brightness); // Add brightness as byte
    byteArray.addAll(rgb); // Add RGB values
    byteArray.add(temperature.toInt()); // Add temperature value

    // You can add more data here for Bluetooth communication
    return byteArray;
  }

  // Copy method to make a modified copy of the Module
  Module copyWith({
    String? id,
    String? label,
    bool? isOn,
    int? brightness,
    List<int>? rgb,
    double? temperature,
  }) {
    return Module(
      id: id ?? this.id,
      label: label ?? this.label,
      isOn: isOn ?? this.isOn,
      brightness: brightness ?? this.brightness,
      rgb: rgb ?? this.rgb,
      temperature: temperature ?? this.temperature,
    );
  }

  @override
  List<Object?> get props => [id, label, isOn, brightness, rgb, temperature];
}

