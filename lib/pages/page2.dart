import 'package:flutter/material.dart';
import 'package:illuden/widgets/bluetooth/bluetooth_bar_view.dart';
import 'package:illuden/widgets/light_settings/selectors/temperature_view.dart';
import 'package:illuden/widgets/light_settings/power_view.dart';
import 'package:illuden/widgets/light_settings/brightness_view.dart';
import 'package:illuden/widgets/navigation/page_2_navigation_view.dart';
import 'package:illuden/widgets/body_view.dart';
class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Page 2'),
      // ),
      body: BodyView(
      children: [
        BluetoothView(),
        SizedBox(height: 5),
        Page2NavigationView(),
        TemperatureView(),
        SizedBox(height: 5),
        BrightnessView(),
        PowerView(),
      ],
      ),
    );
  }
}