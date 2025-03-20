import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/utils/lights/lights.dart';
import 'package:illuden/assets/constants.dart';
import 'package:illuden/widgets/atomic/light_settings/circle_color_picker.dart';
class RGBView extends StatelessWidget {
  RGBView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        // Assuming state.module.LEDs['RGB'] is an int list like [r, g, b]
        final List<int> rgbList = state.module.LEDs['RGB'] ?? [0, 0, 0]; // Default to [0, 0, 0] if null
        final Color color = Color.fromRGBO(rgbList[0], rgbList[1], rgbList[2], 1); // Convert to Color
        final bool isON = state.module.isON;

        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - Constants.selectorHorizontalPadding,
            height: MediaQuery.of(context).size.width - Constants.selectorHorizontalPadding + Constants.selectorVerticalPadding,
            child: RGBSelector(
              initialColor: color,
              isON: isON,
            ), // Pass the converted color and isON to the RGBSelector
          ),
        );
      },
    );
  }
}

class RGBSelector extends StatefulWidget {
  final Color initialColor;
  final bool isON;

  RGBSelector({Key? key, required this.initialColor, required this.isON}) : super(key: key);

  @override
  _RGBSelectorState createState() => _RGBSelectorState();
}

class _RGBSelectorState extends State<RGBSelector> {
  late Color _currentColor;
  late CircleColorPickerController _controller;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.initialColor; // Initialize with the color from the widget
    _controller = CircleColorPickerController(initialColor: _currentColor);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleColorPicker(
        controller: _controller,
        onChanged: (color) {
          // If isON is false, change it to true when the color changes
          if (!widget.isON) {
            context.read<LightsCubit>().togglePower(); // Assuming you have a method to toggle the lights on
          }

          context.read<LightsCubit>().circadianPreset(toggle: false);

          // Update the RGB color in the cubit
          context.read<LightsCubit>().updateRgb(color);
        },
        size: Size(
          MediaQuery.of(context).size.width - Constants.selectorHorizontalPadding,
          MediaQuery.of(context).size.width - Constants.selectorHorizontalPadding,
        ),
        strokeWidth: 6.0,
        thumbSize: 30.0,
        textStyle: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
