
import 'package:flutter/material.dart';
import 'package:illuden/widgets/bluetooth/cubit/bluetooth_single_write.dart';
import 'package:illuden/widgets/bluetooth/bluetooth_bar_view.dart';
// import 'page2.dart';
import 'package:illuden/widgets/light_settings/selectors/sections_view.dart';
import 'package:illuden/widgets/light_settings/brightness_view.dart';
import 'package:illuden/widgets/light_settings/power_view.dart';
import 'package:illuden/widgets/navigation/page_1_navigation_view.dart';
import 'package:illuden/widgets/body_view.dart';
class Page1 extends StatelessWidget {
  const Page1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Page 1'),
      // ),
      body: BodyView(
      children: [
        BluetoothView(),
        SizedBox(height: 5),
        Page1NavigationView(),
        SectionsView(),
        SizedBox(height: 5),
        BrightnessView(),
        PowerView(),
        BluetoothWritePage(),
      ],
      ),
    );
  }
}