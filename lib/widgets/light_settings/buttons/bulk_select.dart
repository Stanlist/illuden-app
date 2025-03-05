
import '../../../utils/lights/lights.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../assets/constants.dart';


class BulkSelectToggle extends StatelessWidget {
  const BulkSelectToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        bool allSelected = state.selectedSections.length == Constants.allSections.length;
        bool noneSelected = state.selectedSections.isEmpty;
        List<bool> isSelected = [allSelected, noneSelected];

        return ToggleButtons(
          color: Colors.black.withOpacity(0.70),
          selectedColor: Theme.of(context).colorScheme.primary,
          selectedBorderColor: Theme.of(context).colorScheme.primary,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
          hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.04),
          borderRadius: BorderRadius.circular(18.0),
          borderColor: isSelected.contains(false)
            ? Theme.of(context).colorScheme.outline // Change to desired color for unselected state
            : Theme.of(context).colorScheme.primary, // Optional: To hide border when selected
          constraints: const BoxConstraints(minHeight: 36.0),
          isSelected: isSelected,
          onPressed: (index) {
            if (index == 0) {
              context.read<LightsCubit>().selectAll();
            } else if (index == 1) {
              context.read<LightsCubit>().deselectAll();
            }
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Select All"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Deselect All"),
            ),
          ],
        );
      },
    );
  }
}