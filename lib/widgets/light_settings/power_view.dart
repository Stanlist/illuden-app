import 'package:flutter/material.dart';
import 'package:illuden/widgets/light_settings/buttons/power_switch.dart';





class PowerView extends StatelessWidget {
  const PowerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        // const Text("Power", style: TextStyle(fontSize: 16)),
        Expanded(child: Container()), 
        const PowerSwitch(),
      ],
    );
  }
}
