import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/utils/lights/lights.dart';

class SelectIndirect extends StatelessWidget {
  const SelectIndirect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        // Assuming you have a boolean in your state indicating the selection status
        bool isIndirectSelected = context.read<LightsCubit>().isIndirectSelected();

        return Container(
          constraints: const BoxConstraints(
            minWidth: 105.0,
            minHeight: 36.0,
          ),
          padding: const EdgeInsets.only(left: 7, right: 10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), width: 1.5),
          ),
          child: Row(
            children: [
              Checkbox(
                // title: const Text('Indirect Lighting'),
                value: isIndirectSelected,
                onChanged: (bool? newValue) {
                  context.read<LightsCubit>().toggleIndirect();
                },
                activeColor: Theme.of(context).colorScheme.onPrimaryContainer,
                visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0)
              ),
              Text('Indirect Lighting'),
            ],
          ),
        );
      },
    );
  }
}