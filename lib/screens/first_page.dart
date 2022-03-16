import 'dart:io';

import 'package:diet_planner_app/screens/CreatePlanPage.dart';
import 'package:diet_planner_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';

import '../models/DietModel.dart';
import '../utils/ConstantData.dart';
import '../utils/ConstantWidget.dart';
import '../utils/DataFile.dart';
import '../utils/PrefData.dart';
import '../utils/SizeConfig.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPage createState() {
    return _FirstPage();
  }
}

class _FirstPage extends State<FirstPage> {
  int _position = 0;
  int _genderPosition = 0;
  int _itemPosition = 0;
  int _itemAboutPosition = 0;
  int _motivatePosition = 0;
  int _variedPosition = 0;
  double _calorie = 2200;
  double tabHeight = 0;
  double tabWidth = 0;
  double tabRadius = 0;
  double? margin;
  bool isCm = true;
  bool isKg = true;

  List<String> selectMealList = [];
  List<DietModel> mealList = DataFile.getMealList();
  List<DietModel> dietList = DataFile.getDietList();
  List<DietModel> motivateList = DataFile.getMotivateList();
  List<DietModel> getGender = DataFile.getGender();

  int cm = 80;
  int inch = 25;
  int ft = 25;
  int kg = 25;
  int age = 22;
  double lbs = 25;

  Future<bool> _requestPop() {
    if (_position > 0) {
      setState(() {
        _position--;
      });
    } else {
      if (Platform.isIOS) {
        exit(0);
      } else {
        SystemNavigator.pop();
      }
      // Future.delayed(const Duration(milliseconds: 200), () {
      //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      // });
    }

    return Future.value(false);
  }

  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();
  }

  setLbsValue() {
    lbs = kg * 2.205;
    lbs = double.parse((lbs).toStringAsFixed(0));

    double total = (cm / 2.54);
    double value = (total / 12);
    double value1 = (total - 12) * value.toInt();

    print("total----$total------$value--------$value1");

    ft = value.toInt();
    inch = value1.toInt();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defMargin = getScreenPercentSize(context, 2);
    margin = getScreenPercentSize(context, 2);
    if (widgetList.isEmpty) {
      getPositionWidget();
    }
    setState(() {});
    return WillPopScope(
        child: Scaffold(
          backgroundColor: cellColor,
          appBar: AppBar(
            backgroundColor: cellColor,
            elevation: 0,
            title: const Text(""),
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace_sharp,
                color: textColor,
              ),
              onPressed: _requestPop,
            ),
          ),
          body: Stack(
            children: [
              Container(
                // child:getHearAboutUsDiet(),
                child:
                    widgetList.isNotEmpty ? widgetList[_position] : Container(),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: defMargin),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    child: Container(
                        height: getScreenPercentSize(context, 7),
                        margin: EdgeInsets.only(
                          bottom: (defMargin * 2),
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              (defMargin / 2),
                            ),
                          ),
                        ),
                        child: InkWell(
                          child: Center(
                            child: getCustomTextWithoutAlign(
                                'Continue',
                                Colors.white,
                                FontWeight.w500,
                                ConstantData.font22Px),
                          ),
                        )),
                    onTap: () {
                      if (_position < (widgetList.length - 1)) {
                        _position++;

                        setState(() {});
                      } else {
                        PrefData.setIsFirstTime(false);
                        // Navigator.of(context).pop(true);
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreatePlanPage(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: getScreenPercentSize(context, 0.7),
                child: Row(
                  children: [
                    for (int i = 0; i < widgetList.length; i++)
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          color: (i <= _position)
                              ? primaryColor
                              : Colors.grey.shade200,
                          height: double.infinity,
                        ),
                        flex: 1,
                      )
                  ],
                ),
              )
            ],
          ),
        ),
        onWillPop: _requestPop);
  }

  getPositionWidget() {
    widgetList.add(firstWidget());
    widgetList.add(getMotivates());
    widgetList.add(ageWidget());
    widgetList.add(heightWidget());
    widgetList.add(calorieSlider());
    widgetList.add(weightWidget());
    widgetList.add(goalWeightWidget());
    widgetList.add(getCurrentDiet());
  }

  Widget getCurrentDiet() {
    SizeConfig().init(context);

    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(margin!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeaderText("What diet are you interested in?"),
            Expanded(
              child: ListView.builder(
                itemCount: dietList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  bool isSelect = (index == _genderPosition);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _genderPosition = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: (margin! / 2)),
                      padding: EdgeInsets.symmetric(
                          horizontal: (margin!), vertical: (margin!)),
                      decoration: BoxDecoration(
                          color: isSelect ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(
                              getScreenPercentSize(context, 1.5))),
                          border: Border.all(
                              color: isSelect
                                  ? Colors.transparent
                                  : subTextColor.withOpacity(0.1),
                              width: 1.5)),
                      child: Row(
                        children: [
                          Image.asset(
                            ConstantData.assetsPath + dietList[index].image!,
                            height: getScreenPercentSize(context, 4),
                          ),
                          SizedBox(
                            width: margin,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTextWidget(
                                    dietList[index].title!,
                                    isSelect ? Colors.white : textColor,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    getScreenPercentSize(context, 1.8)),
                                getTextWidget(
                                    dietList[index].subTitle!,
                                    isSelect ? Colors.white : Colors.grey,
                                    TextAlign.start,
                                    FontWeight.w500,
                                    getScreenPercentSize(context, 1.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getMotivates() {
    SizeConfig().init(context);

    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(margin!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeaderText("What motives you\nthe most?"),
            Expanded(
              child: ListView.builder(
                itemCount: motivateList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  bool isSelect = (index == _motivatePosition);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _motivatePosition = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: (margin! / 2)),
                      padding: EdgeInsets.symmetric(
                          horizontal: (margin!), vertical: (margin!)),
                      decoration: BoxDecoration(
                          color: isSelect ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(
                              getScreenPercentSize(context, 1.5))),
                          border: Border.all(
                              color: isSelect
                                  ? Colors.transparent
                                  : subTextColor.withOpacity(0.1),
                              width: 1.5)),
                      child: Row(
                        children: [
                          Image.asset(
                            ConstantData.assetsPath +
                                motivateList[index].image!,
                            height: getScreenPercentSize(context, 4),
                          ),
                          SizedBox(
                            width: margin,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTextWidget(
                                    motivateList[index].title!,
                                    isSelect ? Colors.white : textColor,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    getScreenPercentSize(context, 1.8)),
                                getTextWidget(
                                    motivateList[index].subTitle!,
                                    isSelect ? Colors.white : Colors.grey,
                                    TextAlign.start,
                                    FontWeight.w500,
                                    getScreenPercentSize(context, 1.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget heightWidget() {
    TextEditingController textEditingController =
        TextEditingController(text: cm.toString());
    TextEditingController textEditingController1 =
        TextEditingController(text: ft.toString());
    TextEditingController textEditingControllerInch =
        TextEditingController(text: inch.toString());

    return StatefulBuilder(
      builder: (context, setState) => Container(
        margin: EdgeInsets.all(margin!),
        child: Stack(
          children: [
            getHeaderText(
              'How tall are you?',
            ),

            Container(
              margin: EdgeInsets.only(bottom: getScreenPercentSize(context, 5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: (margin!)),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IntrinsicWidth(
                            child: getTextField((isCm)
                                ? textEditingController
                                : textEditingController1),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          getTextWidget(
                              (isCm) ? "Cm" : "Ft",
                              subTextColor,
                              TextAlign.end,
                              FontWeight.w600,
                              getScreenPercentSize(context, 2)),
                          const SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: (!isCm),
                            child: IntrinsicWidth(
                              child: getTextField(textEditingControllerInch),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Visibility(
                            visible: (!isCm),
                            child: getTextWidget(
                                "In",
                                subTextColor,
                                TextAlign.end,
                                FontWeight.w600,
                                getScreenPercentSize(context, 2)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 0.5),
                  ),
                  getTabWidget(setState)
                ],
              ),
            )

            // getTextWidget(
            //     S.of(context).howTallAreYou,
            //     Colors.black,
            //     TextAlign.left,
            //     FontWeight.bold,
            //     getScreenPercentSize(context, 4.2)),
            // SizedBox(
            //   height: getScreenPercentSize(context, 0.5),
            // ),
            // getTextWidget(
            //     S.of(context).toGiveYouABetterExperienceNweNeedToKnowHeight,
            //     Colors.black54,
            //     TextAlign.left,
            //     FontWeight.w300,
            //     getScreenPercentSize(context, 2)),
            // SizedBox(
            //   height: getScreenPercentSize(context, 3),
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       height: (height * 1.3),
            //       width: height,
            //       margin: EdgeInsets.symmetric(
            //           horizontal:
            //               getScreenPercentSize(context, 1)),
            //       padding: EdgeInsets.symmetric(
            //           vertical:
            //               getScreenPercentSize(context, 2.5)),
            //       child: Stack(
            //         children: [
            //           Container(
            //             width: (subHeight * 1.2),
            //             height: subHeight,
            //             margin: EdgeInsets.only(top: cellHeight / 2),
            //             padding: EdgeInsets.only(
            //                 left: cellHeight / 2, bottom: cellHeight / 3),
            //             decoration: BoxDecoration(
            //               color: backgroundColor,
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(
            //                     getPercentSize(subHeight, 15)),
            //               ),
            //             ),
            //             child: Row(
            //               crossAxisAlignment: CrossAxisAlignment.end,
            //               children: [
            //                 getTextWidget(
            //                     cm.toString(),
            //                     Colors.black,
            //                     TextAlign.end,
            //                     FontWeight.w300,
            //                     getPercentSize(subHeight, 25)),
            //                 getTextWidget(
            //                     S.of(context).cm,
            //                     primaryColor,
            //                     TextAlign.end,
            //                     FontWeight.w300,
            //                     getPercentSize(subHeight, 15)),
            //               ],
            //             ),
            //           ),
            //           Container(
            //             width: cellHeight,
            //             height: cellHeight,
            //             margin: EdgeInsets.only(left: (cellHeight / 2)),
            //             decoration: BoxDecoration(
            //               color: primaryColor,
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(
            //                     getPercentSize(cellHeight, 30)),
            //               ),
            //             ),
            //             child: Center(
            //               child: Image.asset(
            //                 ConstantData.assetsPath + "height.png",
            //                 height: getPercentSize(cellHeight, 40),
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       height: (height * 1.3),
            //       width: height,
            //       margin: EdgeInsets.symmetric(
            //           horizontal:
            //               getScreenPercentSize(context, 1)),
            //       padding: EdgeInsets.symmetric(
            //           vertical:
            //               getScreenPercentSize(context, 2.5)),
            //       child: Stack(
            //         children: [
            //           Container(
            //             width: (subHeight * 1.2),
            //             height: subHeight,
            //             margin: EdgeInsets.only(top: cellHeight / 2),
            //             padding: EdgeInsets.only(
            //                 left: cellHeight / 2, bottom: cellHeight / 3),
            //             decoration: BoxDecoration(
            //               color: backgroundColor,
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(
            //                     getPercentSize(subHeight, 15)),
            //               ),
            //             ),
            //             child: Row(
            //               crossAxisAlignment: CrossAxisAlignment.end,
            //               children: [
            //                 // Expanded(
            //                 //   child:
            //                 getTextWidget(
            //                     ft.toString(),
            //                     Colors.black,
            //                     TextAlign.start,
            //                     FontWeight.w300,
            //                     getPercentSize(subHeight, 20)),
            //                 // ),
            //                 getTextWidget(
            //                     S.of(context).ft,
            //                     primaryColor,
            //                     TextAlign.end,
            //                     FontWeight.w300,
            //                     getPercentSize(subHeight, 15)),
            //
            //
            //                 SizedBox(width: getPercentSize(subHeight, 5),),
            //                 getTextWidget(
            //                     inch.toString(),
            //                     Colors.black,
            //                     TextAlign.start,
            //                     FontWeight.w300,
            //                     getPercentSize(subHeight, 20)),
            //                 // ),
            //                 getTextWidget(
            //                     S.of(context).inches,
            //                     primaryColor,
            //                     TextAlign.end,
            //                     FontWeight.w300,
            //                     getPercentSize(subHeight, 15)),
            //               ],
            //             ),
            //           ),
            //           Container(
            //             width: cellHeight,
            //             height: cellHeight,
            //             margin: EdgeInsets.only(left: (cellHeight / 2)),
            //             decoration: BoxDecoration(
            //               color: primaryColor,
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(
            //                     getPercentSize(cellHeight, 30)),
            //               ),
            //             ),
            //             child: Center(
            //               child: Image.asset(
            //                 ConstantData.assetsPath+ "ft.png",
            //                 height: getPercentSize(cellHeight, 40),
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Center(
            //   child: Container(
            //     width: getWidthPercentSize(context, 70),
            //
            //     padding: EdgeInsets.symmetric(
            //         vertical: getScreenPercentSize(context, 2.5)),
            //
            //     child: Align(
            //       alignment: Alignment.topCenter,
            //       child: NumberPicker(
            //         value: cm,
            //         minValue: 80,
            //         maxValue: 350,
            //         textStyle: TextStyle(
            //             fontSize: getScreenPercentSize(context, 2),
            //             color: Colors.black,
            //             fontFamily: ConstantData.fontFamily
            //         ),
            //         selectedTextStyle: TextStyle(
            //             fontSize: getScreenPercentSize(context, 5),
            //             color: primaryColor,
            //             fontFamily: ConstantData.fontFamily),
            //         step: 1,
            //         haptics: true,
            //         onChanged: (value) => setState(() {
            //           cm = value;
            //           setLbsValue();
            //         }),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  getTextField(TextEditingController editingController) {
    return TextField(
        maxLines: 1,
        controller: editingController,
        cursorColor: primaryColor,
        textAlign: TextAlign.end,
        textAlignVertical: TextAlignVertical.bottom,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        style: TextStyle(
            color: textColor,
            fontSize: getScreenPercentSize(context, 6),
            fontFamily: ConstantData.fontFamily,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            fillColor: Colors.red,
            filled: false,
            hintText: "0",
            border: InputBorder.none,
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: getScreenPercentSize(context, 6),
                fontFamily: ConstantData.fontFamily,
                fontWeight: FontWeight.w500)));
  }

  getTab1(bool isRight, String s, bool isSelect, Function function) {
    tabWidth = getWidthPercentSize(context, 25);
    tabHeight = getScreenPercentSize(context, 6);
    tabRadius = getPercentSize(tabHeight, 50);

    var radius = Radius.circular(tabRadius);
    var radius1 = const Radius.circular(0);
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        width: tabWidth,
        height: tabHeight,
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    (isSelect) ? primaryColor : subTextColor.withOpacity(0.1),
                width: getPercentSize(tabHeight, 3)),
            borderRadius: BorderRadius.only(
              topLeft: (isRight) ? radius1 : radius,
              bottomLeft: (isRight) ? radius1 : radius,
              topRight: (isRight) ? radius : radius1,
              bottomRight: (isRight) ? radius : radius1,
            )),
        child: Center(
          child: getTextWidget(s, (isSelect) ? primaryColor : subTextColor,
              TextAlign.center, FontWeight.w600, getPercentSize(tabWidth, 16)),
        ),
      ),
    );
  }

  getTabWidget(var setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getTab1(false, "Ft", !isCm, () {
          setState(() {
            isCm = false;
          });
        }),
        getTab1(true, "Cm", isCm, () {
          setState(() {
            isCm = true;
          });
        }),
      ],
    );
  }

  getWeightTabWidget(var setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getTab1(false, "lb", !isKg, () {
          setState(() {
            isKg = false;
          });
        }),
        getTab1(true, "Kg", isKg, () {
          setState(() {
            isKg = true;
          });
        }),
      ],
    );
  }

  Widget ageWidget() {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        color: cellColor,
        margin: EdgeInsets.all(margin!),
        child: Stack(
          children: [
            getHeaderText(
              "How old are you?",
            ),
            Align(
              alignment: Alignment.center,
              child: NumberPicker(
                value: age,
                itemHeight: getScreenPercentSize(context, 12),
                minValue: 18,
                maxValue: 350,
                textStyle: TextStyle(
                    fontSize: getScreenPercentSize(context, 5),
                    color: Colors.black,
                    fontFamily: ConstantData.fontFamily),
                selectedTextStyle: TextStyle(
                    fontSize: getScreenPercentSize(context, 8),
                    color: primaryColor,
                    fontFamily: ConstantData.fontFamily),
                step: 1,
                haptics: true,
                onChanged: (value) => setState(() {
                  age = value;
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget goalWeightWidget() {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        margin: EdgeInsets.all(margin!),
        child: Stack(
          children: [
            getHeaderText(
              "What's your goal\nweight?",
            ),
            Container(
              margin: EdgeInsets.only(bottom: getScreenPercentSize(context, 5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: (margin!)),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IntrinsicWidth(
                            child: getTextField(TextEditingController(
                                text: (isKg) ? kg.toString() : lbs.toString())),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          getTextWidget(
                              (isKg) ? "Kg" : "lb",
                              subTextColor,
                              TextAlign.end,
                              FontWeight.w600,
                              getScreenPercentSize(context, 2)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 0.5),
                  ),
                  getWeightTabWidget(setState)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget weightWidget() {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        margin: EdgeInsets.all(margin!),
        child: Stack(
          children: [
            getHeaderText(
              "What's your current\nweight?",
            ),
            Container(
              margin: EdgeInsets.only(bottom: getScreenPercentSize(context, 5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: (margin!)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IntrinsicWidth(
                          child: getTextField(TextEditingController(
                              text: (isKg) ? kg.toString() : lbs.toString())),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        getTextWidget(
                            (isKg) ? "Kg" : "lb",
                            subTextColor,
                            TextAlign.end,
                            FontWeight.w600,
                            getScreenPercentSize(context, 2)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 0.5),
                  ),
                  getWeightTabWidget(setState)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getHeaderText(String s) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 4)),
        child: getTextWidget(s, textColor, TextAlign.center, FontWeight.bold,
            getScreenPercentSize(context, 3)),
      ),
    );
  }

  Widget firstWidget() {
    SizeConfig().init(context);

    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(margin!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeaderText("Tell us about your self?"),
            Expanded(
              child: ListView.builder(
                itemCount: getGender.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  bool isSelect = (index == _genderPosition);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _genderPosition = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: (margin! / 2)),
                      padding: EdgeInsets.symmetric(
                          horizontal: (margin!), vertical: (margin!)),
                      decoration: BoxDecoration(
                          color: isSelect ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(
                              getScreenPercentSize(context, 1.5))),
                          border: Border.all(
                              color: isSelect
                                  ? Colors.transparent
                                  : subTextColor.withOpacity(0.1),
                              width: 1.5)),
                      child: Row(
                        children: [
                          Image.asset(
                            ConstantData.assetsPath +
                                getGender[index].subTitle!,
                            height: getScreenPercentSize(context, 8),
                          ),
                          SizedBox(
                            width: margin,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTextWidget(
                                    getGender[index].title!,
                                    isSelect ? Colors.white : textColor,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    getScreenPercentSize(context, 1.8)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget calorieSlider() {
    SizeConfig().init(context);
    return StatefulBuilder(
      builder: (context, state) => Column(
        children: [
          getHeaderText('Select your goal calorie!'),
          Slider(
            label: 'Amount : ${_calorie.round().toString()} kCal',
            value: _calorie,
            max: 5000,
            divisions: 20,
            inactiveColor: Colors.black12,
            activeColor: primaryColor,
            onChanged: (double value) {
              state(() {
                _calorie = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
