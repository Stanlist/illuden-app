
import 'package:flutter/material.dart';
// import 'package:illuden/widgets/bluetooth/cubit/bluetooth_single_write.dart';
import 'package:illuden/widgets/bluetooth/bluetooth_bar_view.dart';
import 'package:illuden/widgets/composite/light_settings/presets_view.dart';
import 'package:illuden/widgets/composite/light_settings/sections_view.dart';
import 'package:illuden/widgets/composite/light_settings/brightness_view.dart';
import 'package:illuden/widgets/composite/light_settings/power_view.dart';
import 'package:illuden/widgets/composite/navigation/page_1_navigation_view.dart';
import 'package:illuden/widgets/containers/body_view.dart';
class Page1 extends StatelessWidget {
  const Page1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyView(
      children: [
        BluetoothView(),
        const SizedBox(height: 5),
        Page1NavigationView(),
        SectionsView(),
        const SizedBox(height: 5),
        BrightnessView(),
        const SizedBox(height: 10),
        Page1PowerView(),
        const SizedBox(height: 10),
        PresetsView(),
      ],
      ),
    );
  }
}