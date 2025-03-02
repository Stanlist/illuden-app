
import 'package:flutter/material.dart';
import 'package:illuden/widgets/bluetooth/cubit/bluetooth_single_write.dart';
import 'package:illuden/widgets/bluetooth/bluetooth_bar_view.dart';
// import 'page2.dart';
import 'package:illuden/widgets/selector/selector_view.dart';
import 'package:illuden/widgets/light_settings/brightness_view.dart';
import 'package:illuden/widgets/light_settings/power_view.dart';
import 'package:illuden/widgets/navigation/next_view.dart';
class Page1 extends StatelessWidget {
  const Page1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: Page1Body(),
    );
  }
}
class Page1Body extends StatelessWidget {
  const Page1Body({super.key});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Flexible(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Page1Widgets(),
            ),
        ),
    );
  }
}

class Page1Widgets extends StatelessWidget {
  const Page1Widgets({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          const BluetoothBarView(),
          const NextView(),
          SelectorView(),
          const BrightnessView(),
          const PowerView(),
          const BluetoothWritePage(),
        ],
    );
  }
}


// class NextView extends StatelessWidget {
//   const NextView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(child: Container()), 
//         NextButton(),
//       ],
//     );
//   }
// }

// class NextButton extends StatelessWidget {
//   const NextButton({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const Page2()),
//         );
//       },
//       child: const Text('Next'),
//     );
//   }
// }