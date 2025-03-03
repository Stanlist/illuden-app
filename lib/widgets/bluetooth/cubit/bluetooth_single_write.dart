/*
  Defines the BluetoothBar widget which is a custom app bar that displays the bluetooth status
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illuden/widgets/bluetooth/cubit/bluetooth_cubit.dart';

class BluetoothWritePage extends StatelessWidget {
  const BluetoothWritePage({super.key});

  @override
  Widget build(BuildContext context) {

    // bloc provider
    return BluetoothSingleWrite();
  }
}

class BluetoothSingleWrite extends StatelessWidget {
  const BluetoothSingleWrite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothCubit, BluetoothState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isConnected 
            ? () async {
                try {
                  // Get the bluetooth cubit to write to the device
                  final cubit = context.read<BluetoothCubit>();
                  print("Writing to bluetooth");
                  cubit.write(3,[16,17,18,19,20],20,20,20,0,0,0); // Example data
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Data written successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Write failed: $e')),
                  );
                }
              }
            : null, // Disable button when not connected
          child: const Text("Write to Bluetooth")
        );
      },
    );
  }
}
