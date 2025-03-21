import 'package:flutter/material.dart';
import 'package:illuden/pages/page2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/utils/lights/lights.dart';
import 'package:illuden/widgets/atomic/navigation_button.dart';
import 'package:illuden/widgets/atomic/light_settings/select_indirect.dart';
class Page1NavigationView extends StatelessWidget {
  const Page1NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SelectIndirect(),
        Expanded(child: Container()),
        BlocBuilder<LightsCubit, LightsState>(
          builder: (context, state) {
            // Assuming `noSelectedModules()` is a method from LightsCubit that returns a boolean.
            bool isEnabled = !context.read<LightsCubit>().noSelectedModules();

            return NavigationButton(
              text: 'Next',
              destination: Page2(),
              isEnabled: isEnabled, // Enable/disable the button based on the state
            );
          },
        ),
      ],
    );
  }
}