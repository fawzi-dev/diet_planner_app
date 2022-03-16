import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'SizeConfig.dart';

Color lightPink = Color(0xFFFBE8EA);

Color primaryColor = "#0A776B".toColor();
// Color primaryColor = "#288E2E".toColor();
// Color primaryColor = "#2EA34A".toColor();
Color primaryDarkColor = "#117328".toColor();
Color accentColor = "#E83D35".toColor();
Color backgroundColor = "#F0F4F7".toColor();
Color textColor = "#4E4E4E".toColor();
Color viewColor = "#CCCCCC".toColor();
Color cellColor = "#E4E6ED".toColor();
Color disableIconColor = Colors.black;
Color subTextColor = "#1E1F1F".toColor();

var gradientColors =
    LinearGradient(colors: [primaryColor, "#F65375".toColor()]);


class ConstantData {
  static String fontFamily = "OpenSans";
  // static String fontFamily = "SFProText";
  static String boldFontFamily = "MerriweatherSans";
  static String assetsPath = "assets/images/";
  static final formatter = new NumberFormat("#.##");

  static const double avatarRadius = 40;
  static const double padding = 20;

  static double font18Px = SizeConfig.safeBlockVertical! / 0.5;
  static double font22Px = SizeConfig.safeBlockVertical! / 0.4;
  static double font25Px = SizeConfig.safeBlockVertical! / 0.3;
  static String dateFormat = "EEE ,MMM dd,yyyy";
  static String timeFormat = "hh:mm aa";
}

double feetAndInchToCm(double feet, double inch) {
  double meter;
  double f1 = (feet / 3.281);
  double i1 = (inch / 39.37);
  meter = f1 + i1;
  return meter * 100;
}

 double kgToPound(double kg) {
return kg * 2.205;
// return (total * percent) / 100;
}

 double poundToKg(double kg) {
return kg / 2.205;
// return (total * percent) / 100;
}

void meterToInchAndFeet(double cm, TextEditingController ftController,
    TextEditingController inchController) {
  double meter = cm / 100;
  double inch = (meter * 39.37);
  double ft1 = inch / 12;
  int n = ft1.toInt();
  double in1 = ft1 - n;
  double in2;
  in2 = in1 * 12;
  ftController.text = n.round().toString();
  inchController.text = in2.round().toString();
}
Color getColorFromHex(String colors) {
  var color = "0xFF$colors";
  try {
    return Color(int.parse(color));
  } catch (e) {
    print(e);
    return Color(0xFFFFFFFF);
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
} //////
