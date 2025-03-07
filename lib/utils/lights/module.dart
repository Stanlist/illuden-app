import 'package:equatable/equatable.dart';

class Module extends Equatable {
  int temperature;
  Map<String, dynamic> LEDs;
  bool isON;
  bool isRGBmode;
  int brightness;

  Module({
    this.temperature = 2700,
    Map<String, dynamic>? LEDs,
    this.isON = true,
    this.isRGBmode = false,
    this.brightness = 0,
  }) : LEDs = LEDs ?? {
          '2700': 0,
          '5000': 0,
          '6500': 0,
          'RGB': [0, 0, 0],
        };
  Module copyWith({
    List<int>? selectedAddresses,
    int? temperature,
    Map<String, dynamic>? LEDs,
    bool? isON,
    bool? isRGBmode,
    int? brightness,
    bool? isConnected,
    String? peripheral,
  }) {
    return Module(
      temperature: temperature ?? this.temperature,
      LEDs: LEDs ?? Map.from(this.LEDs),
      isON: isON ?? this.isON,
      isRGBmode: isRGBmode ?? this.isRGBmode,
      brightness: brightness ?? this.brightness,
    );
  }
  @override
  List<Object?> get props => [isRGBmode, isON, brightness, temperature, LEDs];
}

