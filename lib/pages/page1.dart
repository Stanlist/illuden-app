
import 'package:flutter/material.dart';
import 'package:illuden/widgets/bluetooth/cubit/bluetooth_single_write.dart';
import 'package:illuden/widgets/bluetooth/bluetooth_bar_view.dart';
import 'page2.dart';
import 'package:illuden/widgets/selector/selector_view.dart';
import 'package:illuden/widgets/light_settings/brightness_view.dart';
import 'package:illuden/widgets/light_settings/power_view.dart';
class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: Column(
        children: [
          BluetoothBarView(),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectorView(),
                  BrightnessView(),
                  PowerView(),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Page2()),
                    );
                  },
                  child: const Text('Go to Page 2'),
                ),
                BluetoothWritePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
