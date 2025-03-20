import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/utils/lights/lights.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:illuden/assets/constants.dart';
class TemperatureView extends StatelessWidget {
  const TemperatureView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        final int temperature = state.module.temperature;
        final bool isON = state.module.isON; // Get power state
        return Center(
          child: SizedBox(
            // width: Constants.selectorWidth,
            // height: Constants.selectorHeight,
            width: MediaQuery.of(context).size.width - Constants.selectorHorizontalPadding,
            height: MediaQuery.of(context).size.width - Constants.selectorHorizontalPadding + Constants.selectorVerticalPadding,
            child: TemperatureGage(
              temperature: temperature,
              onTemperatureChanged: (value) {
                context.read<LightsCubit>().circadianPreset(toggle: false);
                double step = 20;
                value = (value / step).round() * step;
                  // If close to min or max, snap to the boundary
                if ((6500 - value) < (step*0.8)) {
                  value = 6500;
                } else if ((value - 2700) < (step*0.8)) {
                  value = 2700;
                }
                context.read<LightsCubit>().updateTemperature(value.toInt());
                if(!isON){
                  context.read<LightsCubit>().togglePower();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
class TemperatureLabel extends StatelessWidget {
  final int temperature;
  const TemperatureLabel({super.key, required this.temperature});
  @override
  Widget build(BuildContext context) {
    return Text(
        '${temperature.round()} K',
        style: TextStyle(
        fontSize: 32,
        // fontWeight: FontWeight.w500,
        // color: Theme.of(context).colorScheme.secondary,
    ),
    );
  }
}

class TemperatureGage extends StatelessWidget {
  final int temperature;
  final ValueChanged<double> onTemperatureChanged;

  const TemperatureGage({
    super.key,
    required this.temperature,
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
              value: temperature.toDouble(),
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
              value: temperature.toDouble(),
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
