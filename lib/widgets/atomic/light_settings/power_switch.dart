import 'package:illuden/utils/lights/lights.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PowerSwitch extends StatelessWidget {
  const PowerSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        final bool isON = state.module.isON;

        return Switch(
          value: isON,
          activeColor: Theme.of(context).colorScheme.primary, // Default Flutter Purple
          inactiveTrackColor: Colors.grey.shade400,
          inactiveThumbColor: Colors.grey,
          onChanged: (bool value) => context.read<LightsCubit>().togglePower(),
          thumbIcon: MaterialStateProperty.all(
            const Icon(Icons.power_settings_new, color: Colors.white),
          ),
        );
      },
    );
  }
}

// import 'package:flutter_switch/flutter_switch.dart';
// class PowerSwitch extends StatelessWidget {
//   const PowerSwitch({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LightsCubit, LightsState>(
//       builder: (context, state) {
//         final bool isON = state.module.isON;

//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: FlutterSwitch(
//             width: 70,
//             height: 35,
//             value: isON,
//             borderRadius: 20.0,
//             activeText: "ON",
//             inactiveText: "OFF",
//             activeColor: Theme.of(context).colorScheme.primary,
//             inactiveColor: Colors.grey,
            
//             showOnOff: true,
//             onToggle: (value) {
//               context.read<LightsCubit>().togglePower();
//             },
//           ),
//         );
//       },
//     );
//   }
// }