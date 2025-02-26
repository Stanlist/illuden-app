import 'package:equatable/equatable.dart';
import 'module.dart';

class LightsState extends Equatable {
  final Module module;
  final bool isConnected;

  const LightsState({
    required this.module,
    required this.isConnected,
  });

  // CopyWith method to create a new state with modified properties
  LightsState copyWith({
    Module? module,
    bool? isConnected,
  }) {
    return LightsState(
      module: module ?? this.module,
      isConnected: isConnected ?? this.isConnected,
    );
  }
  @override
  List<Object?> get props => [module, isConnected]; // Implement the props getter
}

class LightsStateInitial extends LightsState {
  LightsStateInitial() : super(
    module: Module(
      id: 'default-id',
      label: 'LED Module',
      isOn: false,
      brightness: 0,
      rgb: [0, 0, 0],
      temperature: 2700.0,
    ),
    isConnected: false,
  );
}
