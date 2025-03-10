import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/utils/lights/lights_cubit.dart';
import 'package:illuden/utils/lights/lights_state.dart';

class PresetsView extends StatelessWidget {
  const PresetsView({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.all(8.0),
    );
    
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Wrap(
          spacing: 8.0, // horizontal spacing between buttons
          runSpacing: 8.0, // vertical spacing between rows
          alignment: WrapAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {context.read<LightsCubit>().applyPreset(taskLightPreset);},
              style: buttonStyle,
              child: const Text('🛋️', style: TextStyle(fontSize: 24)),
            ),
            ElevatedButton(
              onPressed: () {context.read<LightsCubit>().applyPreset(directionalLightPreset);},
              style: buttonStyle,
              child: const Text('🔦', style: TextStyle(fontSize: 24)),
            ),
            ElevatedButton(
              onPressed: () {context.read<LightsCubit>().applyPreset(moodLightPreset);},
              style: buttonStyle,
              child: const Text('✨', style: TextStyle(fontSize: 24)),
            ),
            ElevatedButton(
              onPressed: () {context.read<LightsCubit>().applyPreset(resetLightPreset);},
              style: buttonStyle,
              child: const Text('🔄️', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      );
      } 
    );
  }
}