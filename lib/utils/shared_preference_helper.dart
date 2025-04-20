import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Save a value
  static Future<void> saveKey(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Get a value
  static Future<String?> getKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Remove a value
  static Future<void> removeKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Clear all preferences
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

class PrefsKeys {
  static const String loginSave = 'loginSave';
  static const String loginEmail = 'loginEmail';
}
