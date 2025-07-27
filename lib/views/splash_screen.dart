import 'home_view.dart';
import 'how_to_use_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/splash_cubit/splash_cubit.dart';
import '../cubits/splash_cubit/splash_states.dart';
import '../cubits/how_to_use_view_cubit/how_to_use_view_cubit.dart';
import '../cubits/permission_handler_cubit/permission_handler_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..timer(3000),
      child: BlocListener<SplashCubit, SplashStates>(
        listener: (context, splashState) async {
          if (splashState is SplashDisappear) {
            final seen = await context.read<HowToUseViewCubit>().isSeen();

            await context
                .read<PermissionHandlerCubit>()
                .requestAndEnsureBluetoothAndLocation();

            if (!seen) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HowToUseView()),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeView()),
              );
            }
          }
        },
        child: const Scaffold(
          backgroundColor: Color(0XFF26A59A),
          body: Center(
            child: Text(
              "RoboCar",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
