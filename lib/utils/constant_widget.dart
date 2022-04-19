import 'package:flutter/material.dart';

import 'constant_data.dart';

double getPercentSize(double total, double percent) {
  return (total * percent) / 100;
}

double getScreenPercentSize(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.height * percent) / 100;
}

Widget getHorizonSpace(double space) {
  return SizedBox(
    width: space,
  );
}

double getWidthPercentSize(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.width * percent) / 100;
}

Widget getPrimaryAppBarText(BuildContext buildContext, String s) {
  return getCustomTextWithoutAlign(
      s, Colors.white, FontWeight.w700, getWidthPercentSize(buildContext, 5));
}

Widget getPrimaryAppBarIcon() {
  return const Icon(
    Icons.keyboard_backspace,
    color: Colors.white,
  );
}

Widget getDay(int day,BoxConstraints constraints){
  return Text(
    'Day ${day+1}',
    style: TextStyle(
      fontSize: constraints.maxHeight*0.025,
      fontFamily: 'Roboto-Medium',
      color:const Color(0xB31E1E1E),
    ),
  );
}

Widget getCalorieLabel(String text, BoxConstraints constraints) {
  return Text(
    text,
    style: TextStyle(
      fontSize: constraints.maxHeight * 0.085,
      fontFamily: 'Roboto-Bold',
      color: Colors.white,
    ),
  );
}

Widget getCalorieSubtitle(String text, BoxConstraints constraints) {
  return Text(
    'out of $text kCal',
    style: TextStyle(
      fontSize: constraints.maxHeight * 0.025,
      fontFamily: 'Roboto-Reg',
      color: Colors.white.withOpacity(0.5),
    ),
  );
}

Widget getTextWidget(String text, Color color, TextAlign textAlign,
    FontWeight fontWeight, double textSizes) {
  return Text(
    text,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: textSizes,
        color: color,
        fontFamily: ConstantData.fontFamily,
        fontWeight: fontWeight),
    textAlign: textAlign,
  );
}

Widget getRobotoTextWidget(String text, Color color, TextAlign textAlign,
    FontWeight fontWeight, double textSizes) {
  return Text(
    text,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: textSizes,
        color: color,
        fontFamily: "RobotoMono",
        fontWeight: fontWeight),
    textAlign: textAlign,
  );
}

Widget getBoldTextWidget(String text, Color color, TextAlign textAlign,
    FontWeight fontWeight, double textSizes) {
  return Text(
    text,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: textSizes,
        color: color,
        fontFamily: ConstantData.boldFontFamily,
        fontWeight: fontWeight),
    textAlign: textAlign,
  );
}

double mediumTextSize = 21;

Widget getCustomText(String text, Color color, int maxLine, TextAlign textAlign,
    FontWeight fontWeight, double textSizes) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: textSizes,
        color: color,
        fontFamily: ConstantData.fontFamily,
        fontWeight: fontWeight),
    maxLines: maxLine,
    textAlign: textAlign,
  );
}

Widget getCustomTextWithoutAlign(
    String text, Color color, FontWeight fontWeight, double fontSize) {
  return Text(
    text,
    style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: ConstantData.fontFamily,
        decoration: TextDecoration.none,
        fontWeight: fontWeight),
  );
}
