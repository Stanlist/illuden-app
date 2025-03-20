import 'package:flutter/material.dart';
import 'package:illuden/utils/lights/lights.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CircadianView extends StatelessWidget {
  const CircadianView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        bool isCircadian = state.isCircadian;
        return Switch(
          value: isCircadian,
          activeColor: Theme.of(context).colorScheme.primary, // Default Flutter Purple
          inactiveTrackColor: Colors.grey.shade400,
          inactiveThumbColor: Colors.grey,
          onChanged: (bool value) => context.read<LightsCubit>().circadianPreset(),
          thumbIcon: MaterialStateProperty.all(
            const Icon(Icons.single_bed, color: Colors.white),
          ),
        );
      } 
    );
  }
}
