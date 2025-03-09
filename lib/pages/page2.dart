import 'package:flutter/material.dart';
import 'package:illuden/widgets/bluetooth/bluetooth_bar_view.dart';
import 'package:illuden/widgets/composite/light_settings/temperature_view.dart';
import 'package:illuden/widgets/composite/light_settings/rgb_view.dart';
import 'package:illuden/widgets/composite/light_settings/power_view.dart';
import 'package:illuden/widgets/composite/light_settings/brightness_view.dart';
import 'package:illuden/widgets/composite/navigation/page_2_navigation_view.dart';
import 'package:illuden/widgets/containers/body_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/utils/lights/lights.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optionally include an AppBar if needed
      body: BlocBuilder<LightsCubit, LightsState>(
        builder: (context, state) {
          final isRGBmode = state.module.isRGBmode;
          return BodyView(
            children: [
              BluetoothView(),
              const SizedBox(height: 5),
              Page2NavigationView(),
              // Conditionally display RGBView or TemperatureView
              isRGBmode ? RGBView() : TemperatureView(),
              const SizedBox(height: 5),
              BrightnessView(),
              const SizedBox(height: 10),
              Page2PowerView(),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}