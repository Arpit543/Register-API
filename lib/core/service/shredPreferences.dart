import 'package:shared_preferences/shared_preferences.dart';

class Preferences{


  static const isLogin = "isLogin";
  static const token = "Token";
  static const userName = "UserName";



  static late final SharedPreferences _prefs;

  static Future<SharedPreferences> init() async => _prefs = await SharedPreferences.getInstance();

  static Future<bool> setBool(String key, bool value) async => _prefs.setBool(key, value); //?? Future.value(false);
  static Future<bool> setString(String key, String value) async => _prefs.setString(key, value); //?? Future.value(false);

  static bool getBool(String key) => _prefs.getBool(key) ?? false;
  static String? getString(String key) => _prefs.getString(key);

  ///   Clear All Preference
  static Future<bool> clear() async {
    await _prefs.remove(isLogin);
    await _prefs.remove(token);
    await _prefs.remove(userName);
    return true;
  }

}