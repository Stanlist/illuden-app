/*
  Provides BluetoothCubit to Bluetooth_bar (UI)
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/widgets/bluetooth_bar/bloc/bluetooth_cubit.dart';
import 'package:illuden/widgets/bluetooth_bar/bluetooth_bar_view.dart';

class BluetoothPage extends StatelessWidget {
  const BluetoothPage({super.key});

  @override
  Widget build(BuildContext context) {

    // bloc provider
    return BlocProvider(
      create: (context) => BluetoothCubit(),
      
      // bluetooth view (UI)
      child: BluetoothBarView(),
    );
  }
}