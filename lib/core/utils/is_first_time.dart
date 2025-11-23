import 'package:shared_preferences/shared_preferences.dart';

class IsFirstTime {
  static const String isFirstTimeKey = "first_time";

  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isFirstTimeKey) ?? true;
  }

  static Future<void> setNotFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isFirstTimeKey, false);
  }
}