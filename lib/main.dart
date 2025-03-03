// Copyright 2017-2023, Charles Weinberger & Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'utils/lights/lights.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:illuden/widgets/bluetooth/cubit/bluetooth_cubit.dart';
import 'pages/page1.dart';

void main() {
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  runApp(const IlludenApp());
}
class IlludenApp extends StatelessWidget {
  const IlludenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => BluetoothCubit())),
        BlocProvider(create: ((context) => LightsCubit(Module(), context.read<BluetoothCubit>()))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Illuden',
        home: const Page1(),
      ),
    );
  }
}
