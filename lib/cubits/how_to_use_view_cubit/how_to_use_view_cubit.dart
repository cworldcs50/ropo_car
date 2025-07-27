import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HowToUseViewCubit extends Cubit<bool> {
  HowToUseViewCubit() : super(false);

  Future<bool> isSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool("how_to_use_seen") ?? false;
    emit(seen);
    return seen;
  }

  Future<void> markAsSeen() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("how_to_use_seen", true);
  emit(true);
}
}
