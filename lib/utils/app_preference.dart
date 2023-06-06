import 'package:shared_preferences/shared_preferences.dart';

class AppPreference{

  static SharedPreferences sharedPreferences = SharedPreferences.getInstance() as SharedPreferences;

  // Key
  static const LangKey = 'lang';
  static const LoginKey = 'lang';

  static Future init() async => sharedPreferences = await SharedPreferences.getInstance();

  // Set data
  static Future saveLanguage(String lang) async {
    await sharedPreferences.setString(LangKey, lang);
  }

  static Future saveLogin(bool login) async {
    await sharedPreferences.setBool(LoginKey, login);
  }

  // Get data
  static String? getLanguage() {
    return sharedPreferences.getString(LangKey);
  }

  static bool? getLogin() {
    return sharedPreferences.getBool(LoginKey);
  }

  // Clear data
  static void clearLanguage(){
    sharedPreferences.remove(LangKey);
  }

  static void clearLogin(){
    sharedPreferences.remove(LoginKey);
  }




}