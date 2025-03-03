import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/lights/lights.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperatureView extends StatelessWidget {
  const TemperatureView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        final double temperature = state.module.temperature;
        final bool isON = state.module.isON; // Get power state

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center align everything
            children: [
              /// Centered Temperature Slider with Icon
              TemperatureGage(
                temperature: temperature,
                isON: isON,
                onTemperatureChanged: (value) {
                  double step = 10;
                  value = (value / step).round() * step;
                  context.read<LightsCubit>().updateTemperature(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
class TemperatureLabel extends StatelessWidget {
  final double temperature;
  const TemperatureLabel({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Text(
        '${temperature.round()} K',
        style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.secondary,
    ),
    );
  }
}

class TemperatureGage extends StatelessWidget {
  final double temperature;
  final bool isON;
  final ValueChanged<double> onTemperatureChanged;

  const TemperatureGage({
    super.key,
    required this.temperature,
    required this.isON,
    required this.onTemperatureChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 2700,
          maximum: 6500,
          // startAngle: 125,
          // endAngle: 55,
          showLabels: false,
          showTicks: true,
          interval: 400,
          minorTicksPerInterval: 4, // Adds small ticks between major ones
          majorTickStyle: MajorTickStyle(length: 10, thickness: 2),
          minorTickStyle: MinorTickStyle(length: 5, thickness: 1),
          labelOffset: 0.16, offsetUnit: GaugeSizeUnit.factor,
          axisLineStyle: AxisLineStyle(
              cornerStyle: CornerStyle.bothCurve,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: temperature,
              cornerStyle: CornerStyle.bothCurve,
              width: 10,
              sizeUnit: GaugeSizeUnit.logicalPixel,
              gradient: const SweepGradient(
                colors: <Color>[
                  Color(0xFFFFA757),
                  Color(0xFFCDDCFF),
                ],
                stops: <double>[0.25, 0.75],
              ),
            ),
            MarkerPointer(
              value: temperature,
              onValueChanged: onTemperatureChanged,
              enableDragging: true,
              markerHeight: 25,
              markerWidth: 25,
              markerType: MarkerType.circle,
              color: Theme.of(context).colorScheme.surfaceBright,
              borderWidth: 2,
              borderColor: Theme.of(context).colorScheme.outlineVariant,
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 90,
              axisValue: 5,
              positionFactor: 0.2,
              widget: TemperatureLabel(temperature:temperature)
            ),
          ],
        ),
      ],
    );
  }
}
