import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../utils/lights/lights.dart';
class BrightnessView extends StatelessWidget {
  const BrightnessView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        final int brightness = state.module.brightness;
        final bool isON = state.module.isON; // Get power state
        final bool isRGBmode = state.module.isRGBmode;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center align everything
            children: [
              /// Centered Brightness Label
              BrightnessLabel(brightness: brightness),
              const SizedBox(height: 8),

              /// Centered Brightness Slider with Icon
              BrightnessSlider(brightness: brightness, isON: isON, isRGBmode: isRGBmode,),
            ],
          ),
        );
      },
    );
  }
}


class BrightnessLabel extends StatelessWidget {
  final int brightness;

  const BrightnessLabel({super.key, required this.brightness});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Brightness",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "$brightness%",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

/// **Brightness Slider with Icon Widget**
class BrightnessSlider extends StatelessWidget {
  final int brightness;
  final bool isON;
  final bool isRGBmode;
  const BrightnessSlider({super.key, required this.brightness, required this.isON, required this.isRGBmode});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.brightness_5, size: 24, color: Colors.grey),
        const SizedBox(width: 5),
        Expanded(
          child: SfSlider(
            min: 0,
            max: 100,
            value: brightness.toDouble(),
            showTicks: false,
            showLabels: false,
            trackShape: ModRightPadding(),
            onChanged: isON && !isRGBmode && !context.read<LightsCubit>().noSelectedModules()
                ? (value) => context.read<LightsCubit>().setBrightness(value.toInt())
                : null, // Prevent changes if disabled
          ),
        ), 
      ],
    );
  }
}

class ModRightPadding extends SfTrackShape {
  @override
  Rect getPreferredRect(
    RenderBox parentBox,
    dynamic themeData, 
    Offset offset, 
    {bool? isActive}
  ) {
    final Rect defaultRect = super.getPreferredRect(parentBox, themeData, offset, isActive: isActive);
    
    // Reduce only the right padding
    return Rect.fromLTRB(
      defaultRect.left, 
      defaultRect.top, 
      defaultRect.right + 27, // Shift left by 10 to remove right padding
      defaultRect.bottom
    );
  }
}
