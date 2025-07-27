import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  const SharedPreference._();
  factory SharedPreference() => _instance;

  static const _instance = SharedPreference._();

  Future<void> saveFirstTimeFlag() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasRequestedPermissions', true);
  }

  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasRequestedPermissions') ?? false;
  }
}
