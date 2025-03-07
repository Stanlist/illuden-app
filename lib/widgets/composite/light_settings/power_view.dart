import 'package:flutter/material.dart';
import 'package:illuden/widgets/atomic/light_settings/power_switch.dart';
import 'package:illuden/widgets/atomic/light_settings/bulk_select.dart';
import 'package:illuden/widgets/atomic/light_settings/mode_toggle.dart';


class PowerView extends StatelessWidget {
  final Widget leftWidget;
  const PowerView({Key? key, required this.leftWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: leftWidget,
        ),
        const Expanded(child: SizedBox()),
        const PowerSwitch(),
      ],
    );
  }
}

class Page1PowerView extends StatelessWidget {
  const Page1PowerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PowerView(leftWidget: SelectDeselectButtons());
  }
}

class Page2PowerView extends StatelessWidget {
  const Page2PowerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PowerView(leftWidget: ModeToggle());
  }
}


// class Page2PowerView extends StatelessWidget {
//   const Page2PowerView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children:  [
//         Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: ModeToggle(),
//         ),
//         Expanded(child: Container()), 
//         const PowerSwitch(),
//       ],
//     );
//   }
// }
