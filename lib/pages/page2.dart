import 'package:flutter/material.dart';
import 'package:illuden/widgets/light_settings/temperature_view.dart';
import 'package:illuden/widgets/light_settings/power_view.dart';
import 'package:illuden/widgets/light_settings/brightness_view.dart';
import 'package:illuden/widgets/body_view.dart';
class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: BodyView(
      children: [
        TemperatureView(),
        BrightnessView(),
        PowerView(),
      ],
      ),
    );
  }
}