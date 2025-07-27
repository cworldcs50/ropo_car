import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IsFirstTimeOpenApplicationCubit extends Cubit<bool> {
  IsFirstTimeOpenApplicationCubit() : super(true);

  Future<void> isFirstTimeOpenApplication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool isFirstTime =
        prefs.getBool("isFirstTimeOpenApplication") ?? true;

    if (isFirstTime) {
      await prefs.setBool("isFirstTimeOpenApplication", false);
      emit(true);
    } else {
      emit(false);
    }
  }
}
