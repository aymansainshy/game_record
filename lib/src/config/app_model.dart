import 'package:shared_preferences/shared_preferences.dart';

class AppModel {
  static bool debug = true;
  static String version = '1.0.0';
  static String appName = 'Karrar';
  static String domain = 'https://kraar-backend.ease-group.com/api';
  static SharedPreferences? preferences;

  // static bool isEnglish = AppLanguage.defaultLanguage.languageCode == 'en';
  // static UserDevice? device;
  static bool isDarkTheme = false;

  // static Directory? storageDir;
  // static User? user;

  // static bool isUserUnknown() {
  // return user == null;
  // }

  ///Singleton factory
  static final AppModel _instance = AppModel._internal();

  factory AppModel() {
    return _instance;
  }

  AppModel._internal();
}
