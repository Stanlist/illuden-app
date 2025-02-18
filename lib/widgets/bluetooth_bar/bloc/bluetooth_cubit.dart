import 'dart:io';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:illuden/utils/snackbar.dart';

class BluetoothState {
  final bool isScanning;
  final bool isConnected;
  final BluetoothAdapterState adapterState;
  final BluetoothConnectionState connectionState;
  final BluetoothDevice? device;

  BluetoothState({this.isScanning = false, this.isConnected = false, this.device, this.adapterState = BluetoothAdapterState.unknown, this.connectionState = BluetoothConnectionState.disconnected});
}

// Bluetooth Cubit for handling bluetooth connection to light
class BluetoothCubit extends Cubit<BluetoothState> {
  final String targetDeviceName = "HUNTER2_DEMO"; // Change this to your device's name
  late StreamSubscription<BluetoothAdapterState> _deviceStateSubscription;
  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;
  Timer? _pollingTimer;

  // Constructor for initial state
  BluetoothCubit() : super(BluetoothState()) {
    _checkAndConnect();
  }

  // Check bluetooth support and connect to device
  Future<void> _checkAndConnect() async {
    if (await FlutterBluePlus.isSupported == false) {
      print("Bluetooth is not supported on this device");
      return;
    }

    // Turn on bluetooth if it's not already on (on iOS, user must manually enable bluetooth)
    if (!kIsWeb && Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    _deviceStateSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      emit(BluetoothState(adapterState: state));
      if (state == BluetoothAdapterState.on) {
        _startScan();
      }
    });
  }

  // Start a BLE scan for the target device
  void _startScan() async {
    try {
      await FlutterBluePlus.startScan(
        withServices:[Guid("180D")],
        withNames:[targetDeviceName],
        // timeout: const Duration(seconds: 15)
      );
      emit(BluetoothState(isScanning: true));   
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e), success: false);
      print(e);
      _checkAndConnect();
    }

    var subscription = FlutterBluePlus.onScanResults.listen((results) {
        if (results.isNotEmpty) {  
          for (ScanResult result in results) {
            if (result.device.advName == targetDeviceName) {
              print("Found device: ${result.device.advName} with remote ID: ${result.device.remoteId}");
              _connectToDevice(result.device);
            }
          }
        }
      },
      onError: (e) => print(e),
    );

    FlutterBluePlus.cancelWhenScanComplete(subscription);
  }

  // Connect to the target device
  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      _connectionStateSubscription = device.connectionState.listen((state) async {
        if (state == BluetoothConnectionState.disconnected) {
          print("Device disconnected. Re-scanning...");
          emit(BluetoothState(isConnected: false));
          Future.delayed(const Duration(seconds: 5), () {
            _startScan();
          });
        } else if (state == BluetoothConnectionState.connected) {
          print("Device connected. Starting polling...");
          FlutterBluePlus.stopScan();
          emit(BluetoothState(isConnected: true, device: device, isScanning: false));
        }
      });
      
    } catch (e) {
      emit(BluetoothState(isConnected: false));
      print("Connection to $targetDeviceName failed with error $e. Re-scanning...");
      Future.delayed(const Duration(seconds: 5), () {
        _startScan();
      });
    }
  }

  // Manual disconnect from device
  void disconnect() {
    if (state.device != null) {
      state.device!.disconnect();
      _pollingTimer?.cancel();
      _pollingTimer = null;
      emit(BluetoothState(isConnected: false));
    }
  }
}
