/*
  Defines the BluetoothBar widget which is a custom app bar that displays the bluetooth status
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/widgets/bluetooth/cubit/bluetooth_cubit.dart';

class BluetoothBarView extends StatelessWidget {
  const BluetoothBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothCubit, BluetoothState>(
      builder: (context, state) {
        return PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            title: Text('Bluetooth: ${state.device?.advName.toString()}\nConnected: ${state.isConnected} Scanning: ${state.isScanning}'),
          ),
        );
      },
    );
  }
}
