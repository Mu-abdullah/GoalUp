import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? shared;

  static init() async {
    shared = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await shared!.setString(key, value);
    if (value is int) return await shared!.setInt(key, value);
    if (value is bool) return await shared!.setBool(key, value);
    return await shared!.setDouble(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return shared?.get(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await shared!.remove(key);
  }

  bool containPreference(String key) {
    if (shared!.get(key) == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<Map<String, dynamic>?> getUserFromPreferences({
    required String key,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString(key);

      if (userJson != null) {
        return jsonDecode(userJson) as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw ('Error retrieving user from preferences: $e');
    }
  }

  static Future<void> saveUserToPreferences({
    required Map<String, dynamic> user,
    required String key,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String userJson = jsonEncode(user);
      await prefs.setString(key, userJson);
    } catch (e) {
      throw ('Error saving user to preferences: $e');
    }
  }
}
