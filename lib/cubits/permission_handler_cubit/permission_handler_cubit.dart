import '../../helpers/shared_preference.dart';
import 'permission_handler_states.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';

class PermissionHandlerCubit extends Cubit<PermissionHandlerStates> {
  PermissionHandlerCubit() : super(PermissionHandlerStates());

  Future<bool> _requestBluetoothPermissions() async {
    final statusScan = await Permission.bluetoothScan.request();
    final statusConnect = await Permission.bluetoothConnect.request();

    return statusScan.isGranted && statusConnect.isGranted;
  }

  Future<bool> _requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  Future<void> _checkAndTurnOnBluetooth() async {
    final bluetooth = FlutterBluetoothSerial.instance;
    final isEnabled = await bluetooth.isEnabled ?? false;

    if (!isEnabled) {
      await bluetooth.requestEnable();
    }
  }

  Future<void> _checkAndTurnOnLocation() async {
    bool isLocationEnabled = await Permission.location.serviceStatus.isEnabled;
    if (!isLocationEnabled) {
      await AppSettings.openAppSettings(type: AppSettingsType.location);
    }
  }

  Future<void> requestAndEnsureBluetoothAndLocation() async {
    if (!await SharedPreference().isFirstTime()) {
      await SharedPreference().saveFirstTimeFlag();
      bool bluetoothGranted = await _requestBluetoothPermissions();
      if (bluetoothGranted) {
        await _checkAndTurnOnBluetooth();
      }

      bool locationGranted = await _requestLocationPermission();
      if (locationGranted) {
        await _checkAndTurnOnLocation();
      }
    }
  }
}
