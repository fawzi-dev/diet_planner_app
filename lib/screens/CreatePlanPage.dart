import 'dart:io';

import 'package:diet_planner_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../utils/ConstantData.dart';
import '../utils/ConstantWidget.dart';
import '../utils/SizeConfig.dart';

class CreatePlanPage extends StatefulWidget {
  @override
  _CreatePlanPage createState() {
    return _CreatePlanPage();
  }
}

class _CreatePlanPage extends State<CreatePlanPage> {
  Future<bool> _requestPop() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }

    return new Future.value(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double progressHeight = getWidthPercentSize(context, 50);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: cellColor,
          appBar: AppBar(
            backgroundColor: cellColor,
            elevation: 0,
            title: Text(""),
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace_sharp,
                color: textColor,
              ),
              onPressed: _requestPop,
            ),
          ),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1),
                  duration: const Duration(milliseconds: 5000),
                  onEnd: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                  },
                  builder: (context, value, _) {
                    double val = (value * 100 / 10) * 10;
                    var f = new NumberFormat("###.##", "en_US");

                    return Container(
                      height: progressHeight,
                      width: progressHeight,
                      child: Stack(
                        children: [
                          Container(
                            height: progressHeight,
                            width: progressHeight,
                            child: CircularProgressIndicator(
                              strokeWidth: getPercentSize(progressHeight, 6),
                              value: value,
                              color: Colors.grey,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(primaryColor),
                              backgroundColor: subTextColor.withOpacity(0.5),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                getTextWidget(
                                    f.format(val).toString() + " %",
                                    textColor,
                                    TextAlign.center,
                                    FontWeight.bold,
                                    getPercentSize(progressHeight, 15)),
                                getTextWidget(
                                    "Please wait..",
                                    subTextColor,
                                    TextAlign.center,
                                    FontWeight.w600,
                                    getPercentSize(progressHeight, 8))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getScreenPercentSize(context, 4),
                ),
                getTextWidget(
                    "Creating your\ndiet plan",
                    textColor,
                    TextAlign.center,
                    FontWeight.bold,
                    getScreenPercentSize(context, 3))
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}

