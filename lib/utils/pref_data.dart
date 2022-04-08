import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static SharedPreferences? _preferences;
  static String pkgName = "diet_tips_";
  static String signIn = pkgName + "signIn";
  static String isIntro = pkgName + "isIntro";
  static String isCreatePage = pkgName + "isCreatePage";
  static String mode = pkgName + "mode";
  static String keyWeight = pkgName + "keyWeight";
  static String keyHeight = pkgName + "keyHeight";
  static String isKg = pkgName + "isKg";
  static String isIntKey = pkgName + "isIntKey";
  static String keyCalorie = pkgName + "keyCalorie";
  static String isSignedKey = pkgName + "isSignKey";
  static String isGoogleKey = pkgName + "isGoogle";
  static String isAnony = pkgName + "isAnony";
  static String number = pkgName + "isNumber";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setDailyCalorie(List<String> tracking) async =>
      await _preferences?.setStringList(number, tracking);

  static List<String>? getDailyCalorie() => _preferences?.getStringList(number);

  static setIsFirstTime(int num) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(isIntKey, num);
  }

  static int? getIsFirstTime() => _preferences?.getInt(isIntKey);

  addHeight(double sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(keyHeight, sizes);
  }

  addWeight(double sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(keyWeight, sizes);
  }

  addCalories(double calories) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(keyCalorie, calories);
  }

  static double? getCalorie() => _preferences?.getDouble(keyCalorie);

  getWeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    double intValue = prefs.getDouble(keyWeight) ?? 50;
    return intValue;
  }

  getHeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    double intValue = prefs.getDouble(keyHeight) ?? 100;
    return intValue;
  }

  // static setIsSignIn(bool isFav) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(signIn, isFav);
  // }

  // static getIsSignIn() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(signIn) ?? false;
  // }

  static setIsIntro(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isIntro, isFav);
  }

  static bool? getIsIntro() => _preferences?.getBool(isIntro);

  static setIsCreatePlan(bool isPlan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isCreatePage, isPlan);
  }

  static bool? getIsCreatePlan() => _preferences?.getBool(isCreatePage);

  /// Sign in pref data
  // static isSignedIn(bool isSign) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(isSignedKey, isSign);
  // }
  // static bool? getIsSignedIn() => _preferences?.getBool(isSignedKey);

  /// google pref data
  static setIsGoogle(bool isGoog) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isGoogleKey, isGoog);
  }

  static bool? getIsGoogle() => _preferences?.getBool(isGoogleKey);

  /// anonymous user, pref data

  static setIsAnony(String isFace) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(isAnony, isFace);
  }

  static String? getIsAnony() => _preferences?.getString(isAnony);
}
