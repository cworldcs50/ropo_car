import 'dart:developer';
import 'permission_handler_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerCubit extends Cubit<PermissionHandlerStates> {
  PermissionHandlerCubit() : super(PermissionHandlerStates());

  void requestBluetoothPermissions() async {
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted &&
        await Permission.location.request().isGranted) {
      log("Permissions granted!");
    } else {
      log("Bluetooth permissions not granted.");
    }
  }

  Future<void> requestPermissions() async {
    await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
      Permission.microphone,
    ].request();
  }
}
