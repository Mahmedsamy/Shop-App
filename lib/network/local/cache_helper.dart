import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    } else {
      return await sharedPreferences!.setBool(key, value);
    }
  }

  static dynamic getData({required String key}) {
    var value = sharedPreferences!.get(key);
    debugPrint('key $key value type $value');
    return value;
  }

  static Future<bool> removeData({required String key})async {
    return await sharedPreferences!.remove(key);
  }
}