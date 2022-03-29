import 'dart:io';

import 'package:diet_planner_app/screens/create_plan_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

import '../models/diet_model.dart';
import '../utils/constant_data.dart';
import '../utils/constant_widget.dart';
import '../utils/data_file.dart';
import '../utils/pref_data.dart';
import '../utils/size_config.dart';

final user = FirebaseAuth.instance.currentUser;

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
  int _motivatePosition = 0;
  int userPrefPosition = 0;
  int conditionPosition = 0;
  double tabHeight = 0;
  double tabWidth = 0;
  double tabRadius = 0;
  double targetCalorie = 0;
  double lbs1Value = 0.45359237;
  double? margin;

  List<String> selectMealList = [];
  List<DietModel> mealList = DataFile.getMealList();
  List<DietModel> dietList = DataFile.getDietList();
  List<DietModel> motivateList = DataFile.increaseWeightGoal();
  List<DietModel> getGender = DataFile.getGender();
  List<DietModel> getUserPref = DataFile.getUsersPreferences();
  List<DietModel> condition = DataFile.conditionConcerned();

  int cm = 120;
  double kg1 = 45;
  double kg2 = 0.5;
  int age = 20;

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
                    onTap: () async {
                      if (_position < (widgetList.length - 1)) {
                        _position++;
                        setState(() {});
                      } else {
                        PrefData.setIsFirstTime(3);
                        // Navigator.of(context).pop(true);

                        // current weight
                        double currentWeight = kg1;
                        // target weight
                        double goalWeight = kg2;

                        double resultOfWeights = 0;

                        // final BMR results
                        double finalBmr = 0.0;

                        PrefData().addHeight(cm.toDouble());
                        PrefData().addWeight(kg1);

                        if (_genderPosition == 0) {
                          //tagret calorie
                          targetCalorie = (10 * currentWeight) +
                              (6.25 * cm) -
                              (5 * age) +
                              5;

                          /// check for weights
                          if (_genderPosition == 0) {
                            finalBmr = targetCalorie + (kg2 * 500);
                          } else {
                            finalBmr = targetCalorie - (kg2 * 500);
                          }
                        } else {
                          //tagret calorie
                          targetCalorie = (10 * currentWeight) +
                              (6.25 * cm) -
                              (5 * age) -
                              161;

                          /// check for weights
                          if (_genderPosition == 0) {
                            finalBmr = targetCalorie + (kg2 * 500);
                          } else {
                            finalBmr = targetCalorie - (kg2 * 500);
                          }
                        }

                        PrefData().addCalories(finalBmr);
                        PrefData.setIsCreatePlan(false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CreatePlanPage(bmr: finalBmr.round()),
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
    widgetList.add(ageWidget());
    widgetList.add(heightWidget());
    widgetList.add(weightWidget());
    widgetList.add(getUserPrefs());
    widgetList.add(increaseWeight());
    widgetList.add(conditionConcern());
  }

  Widget getUserPrefs() {
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
            getHeaderText("What do you want to do?"),
            Expanded(
              child: ListView.builder(
                itemCount: getUserPref.length,
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
                      margin: EdgeInsets.symmetric(
                        vertical: (margin! / 2),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: (margin!), vertical: (margin!)),
                      decoration: BoxDecoration(
                        color: isSelect ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            getScreenPercentSize(context, 1.5),
                          ),
                        ),
                        border: Border.all(
                            color: isSelect
                                ? Colors.transparent
                                : subTextColor.withOpacity(0.1),
                            width: 1.5),
                      ),
                      child: Row(
                        children: [
                          // FaIcon(FontAwesomeIcons.ups,
                          //     color:
                          //         (isSelect) ? Colors.black54 : Colors.black26),
                          SizedBox(
                            width: margin,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTextWidget(
                                    getUserPref[index].title!,
                                    isSelect ? Colors.white : textColor,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    getScreenPercentSize(context, 2.4)),
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

  Widget conditionConcern() {
    List<IconData> icons = [
      FontAwesomeIcons.heartBroken,
      Icons.no_food_rounded,
      Icons.no_drinks_rounded
    ];

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
            getHeaderText(
                "Is there anything we should be concerned about you?"),
            Expanded(
              child: ListView.builder(
                itemCount: condition.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  bool isSelect = (index == conditionPosition);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        conditionPosition = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: (margin! / 2),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: (margin!), vertical: (margin!)),
                      decoration: BoxDecoration(
                        color: isSelect ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            getScreenPercentSize(context, 1.5),
                          ),
                        ),
                        border: Border.all(
                            color: isSelect
                                ? Colors.transparent
                                : subTextColor.withOpacity(0.1),
                            width: 1.5),
                      ),
                      child: Row(
                        children: [
                          FaIcon(icons[index],
                              color:
                                  (isSelect) ? Colors.black54 : Colors.black26),
                          SizedBox(
                            width: margin,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTextWidget(
                                    condition[index].title!,
                                    isSelect ? Colors.white : textColor,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    getScreenPercentSize(context, 2.4)),
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

  Widget increaseWeight() {
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
            getHeaderText("How many kilograms?"),
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
                        kg2 = double.parse(motivateList[index].title!);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: (margin! / 2),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: (margin!), vertical: (margin!)),
                      decoration: BoxDecoration(
                        color: isSelect ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            getScreenPercentSize(context, 1.5),
                          ),
                        ),
                        border: Border.all(
                            color: isSelect
                                ? Colors.transparent
                                : subTextColor.withOpacity(0.1),
                            width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.weightHanging,
                              color:
                                  (isSelect) ? Colors.black54 : Colors.black26),
                          SizedBox(
                            width: margin,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTextWidget(
                                    '${motivateList[index].title!} Kg',
                                    isSelect ? Colors.white : textColor,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    getScreenPercentSize(context, 2.4)),
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
                            child: getTextField(textEditingController, 'cm'),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          getTextWidget(
                              "Cm",
                              subTextColor,
                              TextAlign.end,
                              FontWeight.w600,
                              getScreenPercentSize(context, 2)),
                          const SizedBox(
                            width: 10,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 0.5),
                  ),
                  // getTabWidget(setState)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getTextField(TextEditingController editingController, String types) {
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
            fontWeight: FontWeight.w500),
      ),
      onChanged: (value) {
        if (types == 'cm') {
          cm = value.isNotEmpty ? int.parse(value) : 0;
        } else if (types == 'kg1') {
          kg1 = value.isNotEmpty ? double.parse(value) : 0;
        } else if (types == 'kg2') {
          kg2 = value.isNotEmpty ? double.parse(value) : 0;
        }
        debugPrint('CM' +
            cm.toString() +
            '\nC-KG1 ' +
            kg1.toString() +
            '\nC-KG2 ' +
            kg2.toString());
      },
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
                          child: getTextField(
                              TextEditingController(
                                text: kg1.toString(),
                              ),
                              'kg1'),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        getTextWidget("Kg", subTextColor, TextAlign.end,
                            FontWeight.w600, getScreenPercentSize(context, 2)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 0.5),
                  ),
                  // getWeightTabWidget(setState)
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
                        debugPrint(_genderPosition.toString());
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
}
