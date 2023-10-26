import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  static Future<void> saveKeyInLocal(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String> getKeyFromLocal(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      final value = prefs.getString(key);
      return value as String;
    }
    return '';
  }

  static Future<bool> hasKeyInLocal(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<void> removeKeyFromLocal(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      await prefs.remove(key);
    }
  }
}
