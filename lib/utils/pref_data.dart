import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static SharedPreferences? _preferences;
  static String pkgName = "diet_tips_";
  static String isIntKey = pkgName + "isIntKey";
  static String keyCalorie = pkgName + "keyCalorie";
  static String isAnony = pkgName + "isAnony";
  static String number = pkgName + "isNumber";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Storing daily intook calories
  static Future setDailyCalorie(List<String> tracking) async =>
      await _preferences?.setStringList(number, tracking);




  static List<String>? getDailyCalorie() => _preferences?.getStringList(number);

  //  Set if user enters the app for the first time 3
  static setIsFirstTime(int num) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(isIntKey, num);
  }

  static int? getIsFirstTime() => _preferences?.getInt(isIntKey);

  // Set and get calorie
  setCalorie(double calories) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(keyCalorie, calories);
  }

  static double? getCalorie() => _preferences?.getDouble(keyCalorie);

  /// get anonymous user // Fawzi
  static setIsAnony(String isFace) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(isAnony, isFace);
  }

  static String? getIsAnony() => _preferences?.getString(isAnony);
}
