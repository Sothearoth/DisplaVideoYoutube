import 'package:shared_preferences/shared_preferences.dart';

class AppPreference{

  static SharedPreferences sharedPreferences = SharedPreferences.getInstance() as SharedPreferences;

  // Key
  static const LangKey = 'lang';

  static Future init() async => sharedPreferences = await SharedPreferences.getInstance();

  // Set data
  static Future saveLanguage(String lang) async {
    await sharedPreferences.setString(LangKey, lang);
  }

  // Get data
  static String? getLanguage() {
    return sharedPreferences.getString(LangKey);
  }

  // Clear data
  static void clearLanguage(){
    sharedPreferences.remove(LangKey);
  }




}