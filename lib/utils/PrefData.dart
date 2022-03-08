import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String pkgName = "diet_tips_";
  static String signIn = pkgName+"signIn";
  static String isIntro =pkgName+ "isIntro";
  static String mode = pkgName+"mode";
  static String keyWeight = pkgName+"keyWeight";
  static String keyHeight = pkgName+"keyHeight";
  static String isKg = pkgName+"isKg";
  static String isFirstTime = pkgName+"isFirstTime";


  static setIsFirstTime(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isFirstTime, isFav);
  }

  static getIsFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isFirstTime) ?? true;
  }


  addHeight(double sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(keyHeight, sizes);
  }

  addWeight(double sizes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(keyWeight, sizes);
  }

  getWeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    double intValue = prefs.getDouble(keyWeight) ?? 50;
    return intValue;
  }


  getIsKgUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    bool intValue = prefs.getBool(isKg) ?? true;
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

  static getIsIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isIntro) ?? true;
  }

  // static setThemeMode(int isFav) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt(mode, isFav);
  // }

  // static getThemeMode() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt(mode) ?? 0;
  // }


}
