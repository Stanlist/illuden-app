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



class BluetoothView extends StatelessWidget {
  const BluetoothView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BluetoothCubit, BluetoothState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: BluetoothText(state: state),
          );
      },
    );
  }
}
class BluetoothText extends StatelessWidget {
  final BluetoothState state;
  
  const BluetoothText({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14.0),
        children: [
          const TextSpan(
            text: 'Bluetooth: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: '${state.device?.advName.toString()}\n'),
          const TextSpan(
            text: 'Connected: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: '${state.isConnected}, '),
          const TextSpan(
            text: 'Scanning: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: '${state.isScanning}'),
        ],
      ),
    );
  }
}


