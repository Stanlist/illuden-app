import 'package:illuden/utils/lights/lights.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/assets/constants.dart';


// class BulkSelectToggle extends StatelessWidget {
//   const BulkSelectToggle({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LightsCubit, LightsState>(
//       builder: (context, state) {
//         bool allSelected = state.selectedSections.length == Constants.allSections.length;
//         bool noneSelected = state.selectedSections.isEmpty;
//         List<bool> isSelected = [allSelected, noneSelected];

//         return ToggleButtons(
//           color: Colors.black.withOpacity(0.70),
//           selectedColor: Theme.of(context).colorScheme.primary,
//           selectedBorderColor: Theme.of(context).colorScheme.primary,
//           fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
//           splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
//           hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.04),
//           borderRadius: BorderRadius.circular(18.0),
//           borderColor: isSelected.contains(false)
//             ? Theme.of(context).colorScheme.outline // Change to desired color for unselected state
//             : Theme.of(context).colorScheme.primary, // Optional: To hide border when selected
//           constraints: const BoxConstraints(minHeight: 36.0),
//           isSelected: isSelected,
//           onPressed: (index) {
//             if (index == 0) {
//               context.read<LightsCubit>().selectAll();
//             } else if (index == 1) {
//               context.read<LightsCubit>().deselectAll();
//             }
//           },
//           children: const [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text("Select All"),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text("Deselect All"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

class SelectDeselectButtons extends StatelessWidget {
  const SelectDeselectButtons({Key? key}) : super(key: key);
  // Utility function to create the button style
  ButtonStyle _buttonStyle(BuildContext context, bool isEnabled) {
    return TextButton.styleFrom(
      foregroundColor: isEnabled
          ? Theme.of(context).colorScheme.onPrimary
          : Theme.of(context).colorScheme.secondaryFixedDim,
      splashFactory: NoSplash.splashFactory,
      backgroundColor: isEnabled
          ? Theme.of(context).colorScheme.primary.withOpacity(0.9)
          : Theme.of(context).colorScheme.surfaceDim,
       minimumSize: const Size(105.0, 36.0),
      textStyle: TextStyle(fontSize: 14),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        bool isSelectAllAvailable = state.selectedSections.length < Constants.allSections.length;
        bool isDeselectAllAvailable = state.selectedSections.isNotEmpty;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Select All Button
            TextButton(
              onPressed: isSelectAllAvailable
                  ? () => context.read<LightsCubit>().selectAll()
                  : null,
              style: _buttonStyle(context, isSelectAllAvailable),
              child: const Text('Select All'),
            ),

            const SizedBox(width: 12),  // Adds space between the buttons
            // Deselect All Button
            TextButton(
              onPressed: isDeselectAllAvailable
                  ? () => context.read<LightsCubit>().deselectAll()
                  : null,
              style: _buttonStyle(context, isDeselectAllAvailable),
              child: const Text('Deselect All'),
            ),
          ],
        );
      },
    );
  }
}
