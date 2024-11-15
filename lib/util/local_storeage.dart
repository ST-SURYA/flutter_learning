import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<dynamic> setData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else {
      throw Exception('Unsupported data type');
    }
  }

  static Future<dynamic> getData(String key, Type type) async {
    final prefs = await SharedPreferences.getInstance();
    if (type == bool) {
      return prefs.getBool(key);
    } else if (type == String) {
      return prefs.getString(key);
    } else if (type == int) {
      return prefs.getInt(key);
    } else if (type == double) {
      return prefs.getDouble(key);
    } else {
      throw Exception('Unsupported data type');
    }
  }

  static Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
