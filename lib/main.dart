import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bluetooth_car/views/splash_screen.dart';
import 'cubits/permission_handler_cubit/permission_handler_cubit.dart';
import 'cubits/connect_to_bluetooth_cubit/connect_to_bluetooth_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BluetoothCar());
}

class BluetoothCar extends StatelessWidget {
  const BluetoothCar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  PermissionHandlerCubit()
                    ..requestPermissions()
                    ..requestBluetoothPermissions(),
        ),
        BlocProvider(create: (context) => ConnectToBluetoothCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
