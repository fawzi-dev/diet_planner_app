import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ConstantData.dart';

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

Widget getAppBarText(BuildContext buildContext, String s) {
  return getCustomTextWithoutAlign(
      s, textColor, FontWeight.bold, getWidthPercentSize(buildContext, 5));
}

Widget getPrimaryAppBarIcon() {
  return Icon(
    Icons.keyboard_backspace,
    color: Colors.white,
  );
}

Widget getAppBarIcon() {
  return Icon(
    Icons.keyboard_backspace,
    color: textColor,
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

Widget getTextWidgetWithSpacing(String text, Color color, TextAlign textAlign,
    FontWeight fontWeight, double textSizes) {
  return Text(
    text,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: textSizes,
        color: color,
        height: 1.5,
        fontFamily: ConstantData.fontFamily,
        fontWeight: fontWeight),
    textAlign: textAlign,
  );
}

Widget getCustomTextWidget(String text, Color color, int maxLine,
    TextAlign textAlign, FontWeight fontWeight, double textSizes) {
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

Widget getCustomTextWidgetWithoutSpace(String text, Color color, int maxLine,
    TextAlign textAlign, FontWeight fontWeight, double textSizes) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        decoration: TextDecoration.none,
        height: 0.50,
        fontSize: textSizes,
        color: color,
        fontFamily: ConstantData.fontFamily,
        fontWeight: fontWeight),
    maxLines: maxLine,
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

Widget getMediumBoldTextWithMaxLine(String text, Color color, int maxLine) {
  return Text(
    text,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: mediumTextSize,
        color: color,
        fontFamily: ConstantData.fontFamily,
        fontWeight: FontWeight.bold),
    maxLines: maxLine,
    textAlign: TextAlign.start,
    overflow: TextOverflow.ellipsis,
  );
}

Widget getMediumTextWithMaxLine(String text, Color color, int maxLine) {
  return Text(
    text,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: ConstantData.font22Px
        ,
        color: color,
        fontFamily: ConstantData.fontFamily,
        fontWeight: FontWeight.w600),
    maxLines: maxLine,
    textAlign: TextAlign.start,
    overflow: TextOverflow.ellipsis,
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

Widget getButtonWidget(
    BuildContext context, String s, var color, Function function) {
  double height = getScreenPercentSize(context, 6.5);
  double radius = getPercentSize(height, 15);
  double fontSize = getPercentSize(height, 35);

  return InkWell(
    child: Container(
      height: height,
      margin:
          EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: Center(
          child: getDefaultTextWidget(
              s, TextAlign.center, FontWeight.w600, fontSize, Colors.white)),
    ),
    onTap: () {
      function();
    },
  );
}

Widget getTextButtonWidget(
    BuildContext context, String s, var color, Function function) {
  double height = getScreenPercentSize(context, 7);
  double radius = getPercentSize(height, 20);
  double fontSize = getPercentSize(height, 30);

  return InkWell(
    child: Container(
      height: height,
      margin:
      EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: Center(
          child: getDefaultTextWidget(
              s, TextAlign.center, FontWeight.w800, fontSize, Colors.white)),
    ),
    onTap: () {
      function();
    },
  );
}

Widget getDefaultTextWidget(String s, TextAlign textAlign,
    FontWeight fontWeight, double fontSize, var color) {
  return Text(
    s,
    textAlign: textAlign,
    style: TextStyle(
        fontFamily: ConstantData.fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color),
  );
}

Widget getDefaultTextFiledWidget(BuildContext context, String s,
    TextEditingController textEditingController) {
  double height = getScreenPercentSize(context, 8.5);

  double radius = getPercentSize(height, 20);
  double fontSize = getPercentSize(height, 25);

  return Container(
    height: height,
    margin: EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      color: cellColor,
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    ),
    child: TextField(
      maxLines: 1,
      controller: textEditingController,
      style: TextStyle(
          fontFamily: ConstantData.fontFamily,
          color: textColor,
          fontWeight: FontWeight.w400,
          fontSize: fontSize),
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: getWidthPercentSize(context, 2)),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: s,
          hintStyle: TextStyle(
              fontFamily: ConstantData.fontFamily,
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: fontSize)),
    ),
  );
}

Widget getPasswordTextFiled(BuildContext context, String s,
    TextEditingController textEditingController) {
  double height = getScreenPercentSize(context, 8.5);
  double radius = getPercentSize(height, 20);
  double fontSize = getPercentSize(height, 25);

  return Container(
      height: height,
      alignment: Alignment.centerLeft,
      margin:
          EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
      decoration: BoxDecoration(
        color: cellColor,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: TextField(
        maxLines: 1,
        obscureText: true,
        controller: textEditingController,
        style: TextStyle(
            fontFamily: ConstantData.fontFamily,
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: fontSize),
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: getWidthPercentSize(context, 2)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: s,
            hintStyle: TextStyle(
                fontFamily: ConstantData.fontFamily,
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: fontSize)),
      ));
}

Widget getButtonWidget1(
    BuildContext context, String s, var color, Function function) {
  double height = getScreenPercentSize(context, 8.5);
  double radius = getPercentSize(height, 20);
  double fontSize = getPercentSize(height, 30);

  return InkWell(
    child: Container(
      height: height,
      margin:
          EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: Center(
          child: getDefaultTextWidget(
              s, TextAlign.center, FontWeight.w500, fontSize, Colors.black)),
    ),
    onTap: () {
      function();
    },
  );
}

Widget getRoundCornerButtonWithoutIcon(String texts, Color color,
    Color textColor, double btnRadius, Function function) {
  return InkWell(
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(btnRadius),
            shape: BoxShape.rectangle,
            color: color,
// border: BorderSide(color: borderColor, width: 1)
          ),

// shape: RoundedRectangleBorder(
//     borderRadius: new BorderRadius.circular(btnRadius),
//     side: BorderSide(color: borderColor, width: 1)),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),

          child: Center(
            child: getCustomText(
                texts, textColor, 1, TextAlign.center, FontWeight.w500, 18),
          ),
        )
      ],
    ),
    onTap: () {
      function();
    },
  );
}

Widget getSmallNormalText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 16,
        color: color,
        fontFamily: ConstantData.fontFamily,
        fontWeight: FontWeight.normal),
  );
}

Widget getBottomText(BuildContext context, String s, Function function) {
  double bottomHeight = getScreenPercentSize(context, 7.6);
  double radius = getPercentSize(bottomHeight, 18);

  return InkWell(
    child: Container(
      height: bottomHeight,
      margin: EdgeInsets.all(
           getPercentSize(bottomHeight, 25),
          ),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: Center(
        child: getTextWidget(s, Colors.white, TextAlign.start, FontWeight.bold,
            getPercentSize(bottomHeight, 30)),
      ),
    ),
    onTap: () {
      function();
    },
  );
}


Widget getSmallBoldText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 16,
        color: color,
        fontFamily: ConstantData.fontFamily,
        fontWeight: FontWeight.bold),
  );
}
Widget getMediumNormalTextWithMaxLine(
    String text, Color color, int maxLine, TextAlign textAlign) {
  return Text(
    text,
    style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: mediumTextSize,
        color: color,
        fontFamily: ConstantData.fontFamily,
        fontWeight: FontWeight.w500),
    maxLines: maxLine,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
  );
}