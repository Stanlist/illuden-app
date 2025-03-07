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
  BluetoothState(
      {this.isScanning = false,
      this.isConnected = false,
      this.device,
      this.adapterState = BluetoothAdapterState.unknown,
      this.connectionState = BluetoothConnectionState.disconnected});
}

// Bluetooth Cubit for handling bluetooth connection, read and writing
class BluetoothCubit extends Cubit<BluetoothState> {
  final String targetDeviceName =
      "HUNTER2_DEMO"; // Change this to your device's name
  late StreamSubscription<BluetoothAdapterState> _deviceStateSubscription;
  late StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;

  // Bluetooth services
  late List<BluetoothService>? _services;
  late BluetoothService? _rwService;
  late BluetoothCharacteristic? _readCharacteristic;
  late BluetoothCharacteristic? _writeCharacteristic;

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

    _deviceStateSubscription =
        FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
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
        withServices: [Guid("180D")],
        withNames: [targetDeviceName],
        // timeout: const Duration(seconds: 15)
      );
      emit(BluetoothState(isScanning: true));
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e),
          success: false);
      print(e);
      _checkAndConnect();
    }

    var subscription = FlutterBluePlus.onScanResults.listen(
      (results) {
        if (results.isNotEmpty) {
          for (ScanResult result in results) {
            if (result.device.advName == targetDeviceName) {
              print(
                  "Found device: ${result.device.advName} with remote ID: ${result.device.remoteId}");
              emit(BluetoothState(device: result.device));
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
      _connectionStateSubscription =
          device.connectionState.listen((state) async {
        if (state == BluetoothConnectionState.disconnected) {
          print("Device disconnected. Re-scanning...");
          emit(BluetoothState(isConnected: false));
          Future.delayed(const Duration(seconds: 5), () {
            _startScan();
          });
        } else if (state == BluetoothConnectionState.connected) {
          print("Device connected.");
          FlutterBluePlus.stopScan();
          emit(BluetoothState(
              isConnected: true, device: device, isScanning: false));

          // Poll for bluetooth services
          _services = await device.discoverServices();
          for (BluetoothService service in _services!) {
            print("Service: ${service.uuid}");
            if (service.uuid == Guid("00ff")) {
              _rwService = service;
              _readCharacteristic = service.characteristics
                  .firstWhere((c) => c.uuid == Guid("FF01"));
              _writeCharacteristic = service.characteristics
                  .firstWhere((c) => c.uuid == Guid("FF02"));
              return;
            }
          }
          print("Missing service 0x00FF!!!!");
        }
      });
    } catch (e) {
      emit(BluetoothState(isConnected: false));
      print(
          "Connection to $targetDeviceName failed with error $e. Re-scanning...");
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

  bool isConnected() {
    return state.isConnected;
  }

  // Write to the device with one of the following types:
  // 1: Single write
  // 2: Multiple write (not implemented)
  // 3: Identical write
  void write(int type, List<int> addresses,
      [int w2700 = 0,
      int w5000 = 0,
      int w6500 = 0,
      int r = 0,
      int g = 0,
      int b = 0]) async {
    print("Trying to write to device...");
    if (state.isConnected && _writeCharacteristic != null) {
      if (type == 3) {

        // Identical write
        List<int> msg = [type, w2700, w5000, w6500, g, r, b];
        msg.addAll(addresses);
        await _writeCharacteristic!.write(msg);
        print("Identical Write Completed");
      } else if (type == 1) {

        // Single write
        await _writeCharacteristic!.write([type, addresses[0], w2700, w5000, w6500, g, r, b]);
        print("Single Write Completed");
      } else {
        print("Invalid write type.");
      }
    } else {
      print("Device not connected or write characteristic not found.");
    }
  }
}
