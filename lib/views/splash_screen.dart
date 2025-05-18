import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/splash_cubit/splash_cubit.dart';
import '../cubits/splash_cubit/splash_states.dart';
import 'home_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..timer(3000),
      child: BlocListener<SplashCubit, SplashStates>(
        listener: (context, state) {
          if (state is SplashDisappear) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          }
        },
        child: Scaffold(
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
