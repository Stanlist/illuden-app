import 'package:flutter/material.dart';
import 'package:illuden/widgets/bluetooth/bluetooth_bar_view.dart';
import 'package:illuden/widgets/bluetooth/cubit/bluetooth_single_write.dart';
import 'package:illuden/widgets/light_settings/selectors/temperature_view.dart';
import 'package:illuden/widgets/light_settings/selectors/rgb_view.dart';
import 'package:illuden/widgets/light_settings/power_view.dart';
import 'package:illuden/widgets/light_settings/brightness_view.dart';
import 'package:illuden/widgets/navigation/page_2_navigation_view.dart';
import 'package:illuden/widgets/body_view.dart';
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
              Page2PowerView(),
              BluetoothWritePage(),
            ],
          );
        },
      ),
    );
  }
}