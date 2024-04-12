// Importing the SharedPreferences package to handle data caching.
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// A helper class for caching data using SharedPreferences.
class CacheHelper {
  // Static variable to hold the SharedPreferences instance.
  static late SharedPreferences sharedPreferences;

  // Method to initialize the SharedPreferences instance asynchronously.
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Method to save data to SharedPreferences based on its type.
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    // Serialize complex data types to JSON strings
    if (value is Map || value is List) {
      value = jsonEncode(value);
    }
    // Checking the type of the value and storing accordingly.
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    // If the value is not of the above types, assume it's a double.
    return await sharedPreferences.setDouble(key, value);
  }

  // Method to retrieve data from SharedPreferences.
  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key) ?? '';
  }

  // Method to remove data associated with a specific key from SharedPreferences.
  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }

  // Method to clear all data stored in SharedPreferences.
  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  // Method to check if a key exists in SharedPreferences.
  static Future<bool> containKey(String key) async {
    return sharedPreferences.containsKey(key);
  }

  // Method to save a list of strings to SharedPreferences.
  static Future<bool> saveList({
    required String key,
    required List<String> value,
  }) async {
    return await sharedPreferences.setStringList(key, value);
  }

  // Method to retrieve a list of strings from SharedPreferences.
  static List<String>? getList({
    required String key,
  }) {
    return sharedPreferences.getStringList(key);
  }

  // Method to remove a list associated with a specific key from SharedPreferences.
  static Future<bool> removeList({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }

  // Method to clear all lists stored in SharedPreferences.
  static Future<bool> clearList() async {
    return await sharedPreferences.clear();
  }
}
