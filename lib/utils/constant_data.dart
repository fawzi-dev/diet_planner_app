import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'size_config.dart';

Color lightPink = const Color(0xFFFBE8EA);
Color primaryColor = "#32a83e".toColor();
Color primaryDarkColor = "#117328".toColor();
Color accentColor = "#E83D35".toColor();
Color backgroundColor = "#F0F4F7".toColor();
Color textColor = "#4E4E4E".toColor();
Color viewColor = "#CCCCCC".toColor();
Color cellColor = "#E4E6ED".toColor();
Color disableIconColor = Colors.black;
Color subTextColor = "#1E1F1F".toColor();

var gradientColors =  LinearGradient(colors: [primaryColor, "#F65375".toColor()]);

class ConstantData {
  static String fontFamily = "OpenSans";
  // static String fontFamily = "SFProText";
  static String boldFontFamily = "MerriweatherSans";
  static String assetsPath = "assets/emojis/";
  static final formatter = NumberFormat("#.##");

  static const double avatarRadius = 40;
  static const double padding = 20;

  static double font18Px = SizeConfig.safeBlockVertical! / 0.5;
  static double font22Px = SizeConfig.safeBlockVertical! / 0.4;
  static double font25Px = SizeConfig.safeBlockVertical! / 0.3;
  static String dateFormat = "EEE ,MMM dd,yyyy";
  static String timeFormat = "hh:mm aa";
}


Color getColorFromHex(String colors) {
  var color = "0xFF$colors";
  try {
    return Color(int.parse(color));
  } catch (e) {
    return const Color(0xFFFFFFFF);
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
} //////
