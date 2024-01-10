import '../config/app_model.dart';

class PreferencesHelper {
  static Future<bool?> clear() async {
    return await AppModel.preferences?.clear();
  }

  static bool containsKey(String key) {
    return AppModel.preferences?.containsKey(key) ?? false;
  }

  static dynamic get(String key) {
    return AppModel.preferences?.get(key);
  }

  static bool? getBool(String key) {
    return AppModel.preferences?.getBool(key);
  }

  static double? getDouble(String key) {
    return AppModel.preferences?.getDouble(key);
  }

  static int? getInt(String key) {
    return AppModel.preferences?.getInt(key);
  }

  static Set<String>? getKeys() {
    return AppModel.preferences?.getKeys();
  }

  static String? getString(String key) {
    return AppModel.preferences?.getString(key);
  }

  static List<String>? getStringList(String key) {
    return AppModel.preferences?.getStringList(key);
  }

  static Future<void> reload() async {
    return await AppModel.preferences?.reload();
  }

  static Future<bool?> remove(String key) async {
    return await AppModel.preferences?.remove(key);
  }

  static Future<bool?> setBool(String key, bool value) async {
    return await AppModel.preferences?.setBool(key, value);
  }

  static Future<bool?> setDouble(String key, double value) async {
    return await AppModel.preferences?.setDouble(key, value);
  }

  static Future<bool?> setInt(String key, int value) async {
    return await AppModel.preferences?.setInt(key, value);
  }

  static Future<bool?> setString(String key, String value) async {
    return await AppModel.preferences?.setString(key, value);
  }

  static Future<bool?> setStringList(String key, List<String> value) async {
    return await AppModel.preferences?.setStringList(key, value);
  }

  ///Singleton factory
  static final PreferencesHelper _instance = PreferencesHelper._internal();

  factory PreferencesHelper() {
    return _instance;
  }

  PreferencesHelper._internal();
}
