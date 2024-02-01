import '../config/app_configration.dart';

class PreferencesHelper {
  static Future<bool?> clear() async {
    return await AppConfig.preferences?.clear();
  }

  static bool containsKey(String key) {
    return AppConfig.preferences?.containsKey(key) ?? false;
  }

  static dynamic get(String key) {
    return AppConfig.preferences?.get(key);
  }

  static bool? getBool(String key) {
    return AppConfig.preferences?.getBool(key);
  }

  static double? getDouble(String key) {
    return AppConfig.preferences?.getDouble(key);
  }

  static int? getInt(String key) {
    return AppConfig.preferences?.getInt(key);
  }

  static Set<String>? getKeys() {
    return AppConfig.preferences?.getKeys();
  }

  static String? getString(String key) {
    return AppConfig.preferences?.getString(key);
  }

  static List<String>? getStringList(String key) {
    return AppConfig.preferences?.getStringList(key);
  }

  static Future<void> reload() async {
    return await AppConfig.preferences?.reload();
  }

  static Future<bool?> remove(String key) async {
    return await AppConfig.preferences?.remove(key);
  }

  static Future<bool?> setBool(String key, bool value) async {
    return await AppConfig.preferences?.setBool(key, value);
  }

  static Future<bool?> setDouble(String key, double value) async {
    return await AppConfig.preferences?.setDouble(key, value);
  }

  static Future<bool?> setInt(String key, int value) async {
    return await AppConfig.preferences?.setInt(key, value);
  }

  static Future<bool?> setString(String key, String value) async {
    return await AppConfig.preferences?.setString(key, value);
  }

  static Future<bool?> setStringList(String key, List<String> value) async {
    return await AppConfig.preferences?.setStringList(key, value);
  }

  ///Singleton factory
  static final PreferencesHelper _instance = PreferencesHelper._internal();

  factory PreferencesHelper() {
    return _instance;
  }

  PreferencesHelper._internal();
}
