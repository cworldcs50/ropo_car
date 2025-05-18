abstract class ConnectToBluetoothStates {}

class BluetoothInitial extends ConnectToBluetoothStates {}

class SearchAboutDevices extends ConnectToBluetoothStates {}

class FoundDevices extends ConnectToBluetoothStates {}

class NoDevicesAvailable extends ConnectToBluetoothStates {}

class BluetoothConnecting extends ConnectToBluetoothStates {}

class BluetoothConnected extends ConnectToBluetoothStates {}

class BluetoothError extends ConnectToBluetoothStates {
  final String message;
  BluetoothError(this.message);
}
