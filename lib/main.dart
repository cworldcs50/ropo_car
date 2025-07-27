import 'views/home_view.dart';
import 'views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/how_to_use_view_cubit/how_to_use_view_cubit.dart';
import 'cubits/permission_handler_cubit/permission_handler_cubit.dart';
import 'cubits/connect_to_bluetooth_cubit/connect_to_bluetooth_cubit.dart';
import 'cubits/is_first_time_open_application_cubit/is_first_time_open_application_cubit.dart';

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
        BlocProvider(create: (context) => PermissionHandlerCubit()),
        BlocProvider(create: (context) => ConnectToBluetoothCubit()),
        BlocProvider(create: (context) => HowToUseViewCubit()),
        BlocProvider(
          create:
              (context) =>
                  IsFirstTimeOpenApplicationCubit()
                    ..isFirstTimeOpenApplication(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<IsFirstTimeOpenApplicationCubit, bool>(
          builder: (context, state) {
            if (state) {
              return SplashScreen();
            } else {
              return HomeView();
            }
          },
        ),
      ),
    );
  }
}
