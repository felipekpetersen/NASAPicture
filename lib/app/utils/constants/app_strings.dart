import 'package:shared_preferences/shared_preferences.dart';

class AppStrings {
  AppStrings._();

  static const baseURL = 'https://api.nasa.gov/';
  static const cacheDuration = 'cache_duration';
  static const cacheStartingDate = 'cache_starting_date';
  static const picturesBox = 'pictures_box';
  //DO NOT USE IN PROD ENVIRONMENT. DEVELOPMENT PURPOSE ONLY.
  static const apiKey = 'aN0r6EcO92ne7rkR8TVVk4zb9y4eJeTCEU4CjxaE';
}

class AppStringsController {

  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static String? getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key);
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance!.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

}