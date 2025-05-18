import 'dart:developer';
import 'dart:typed_data';
import 'connect_to_bluetooth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';

class ConnectToBluetoothCubit extends Cubit<ConnectToBluetoothStates> {
  ConnectToBluetoothCubit() : super(BluetoothInitial());

  List<BluetoothDiscoveryResult> devices = [];
  BluetoothConnection? _connection;
  bool isConnected = false;

  Future<void> scanForDevices() async {
    emit(SearchAboutDevices());

    try {
      FlutterBluetoothSerial.instance
          .startDiscovery()
          .listen((r) {
            if (!devices.any((d) => d.device.address == r.device.address)) {
              devices.add(r);
            }
          })
          .onDone(() {
            emit(FoundDevices());
          });
    } catch (e) {
      emit(BluetoothError("Failed to scan: $e"));
    }
  }

  Future<bool> connectToDevice(BluetoothDevice device) async {
    emit(BluetoothConnecting());

    try {
      _connection = await BluetoothConnection.toAddress(device.address);
      emit(BluetoothConnected());
      return true;
    } catch (e) {
      emit(BluetoothError("Connection failed: $e"));
      return false;
    }
  }

  Future<void> sendCommand(String command) async {
    if (_connection != null && _connection!.isConnected) {
      try {
        _connection!.output.add(Uint8List.fromList(command.codeUnits));
        await _connection!.output.allSent;
      } catch (e) {
        log("Error sending command: $e");
      }
    } else {
      log("No connected device to send command.");
    }
  }

  List<BluetoothDiscoveryResult> get scannedDevices => devices;
}
