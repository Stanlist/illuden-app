

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/utils/lights/lights.dart';
import 'package:toggle_switch/toggle_switch.dart';
class ModeToggle extends StatelessWidget {
  const ModeToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {

        final initialIndex = state.module.isRGBmode ? 0 : 1;
        return ToggleSwitch(
        minWidth: 115.0,
        minHeight: 36.0,
        cornerRadius: 18.0,
        activeBgColor: [Theme.of(context).colorScheme.primary.withOpacity(0.9)],
        activeFgColor: Theme.of(context).colorScheme.onPrimary,
        inactiveBgColor: Theme.of(context).colorScheme.surfaceDim,
        inactiveFgColor: Theme.of(context).colorScheme.outline.withOpacity(0.85),
        initialLabelIndex: initialIndex,
        totalSwitches: 2,
        labels: ['RGB', 'Temperature'],
        radiusStyle: true,
        onToggle: (index) {
          context.read<LightsCubit>().switchMode(index == 0);
        },
      );
      },
    );
  }
}