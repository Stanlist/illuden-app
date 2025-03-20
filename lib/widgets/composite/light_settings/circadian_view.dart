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
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add padding if needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // Add rounded corners if desired
            color: Theme.of(context).colorScheme.primaryContainer, // You can customize the background color
          ),
          child: Row(
            children: [
              Icon(
                Icons.today,
                size: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              const Text(
                'Circadian Lighting',
                style: TextStyle(fontSize: 16), // Set the desired font size here
              ),
              const Expanded(child: SizedBox()),
              Checkbox(
                value: isCircadian,
                onChanged: (bool? value) {
                  context.read<LightsCubit>().circadianPreset();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}