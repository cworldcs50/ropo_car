import 'dart:async';
import 'splash_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashAppear());

  void timer(int milliseconds) async => await Future.delayed(
    Duration(milliseconds: milliseconds),
    () => emit(SplashDisappear()),
  );
}
