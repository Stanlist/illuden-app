import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../utils/lights/lights.dart';
class SyncfusionSliderWidget extends StatelessWidget {
  const SyncfusionSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        final int brightness = state.module.brightness; // Assuming brightness is an int

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:
              Row( 
                  children: [
                    const Text(
                      "Brightness",
                      style: TextStyle(fontSize: 16),
                    ),
                    const Spacer(), // Pushes value to the right
                    Text(
                      "$brightness%",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              
              Row(
                children: [
                  const Icon(Icons.brightness_5, size: 24, color: Colors.grey), // Left icon
                  const SizedBox(width: 5), // Space between icon and slider
                  Expanded(
                    child: SfSlider(
                      min: 0,
                      max: 100,
                      value: brightness.toDouble(),
                      // showTicks: true,
                      // showLabels: true,
                      enableTooltip: true,
                      tooltipTextFormatterCallback: (dynamic value, String text) {
                        return '$text%'; // Adds '%' to tooltip display
                      },
                      // labelFormatterCallback: (value, _) =>
                      //     value == 100 ? '100%' : '',
                      onChanged: (value) =>
                          context.read<LightsCubit>().setBrightness(value.toInt()),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
