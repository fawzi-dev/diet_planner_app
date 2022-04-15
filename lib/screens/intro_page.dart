import 'dart:io';
import 'package:diet_planner_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/intro_model.dart';
import '../utils/colors.dart';
import '../utils/constant_data.dart';
import '../utils/constant_widget.dart';
import '../utils/data_file.dart';
import '../utils/pref_data.dart';
import '../utils/size_config.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPage createState() {
    return _IntroPage();
  }
}

class _IntroPage extends State<IntroPage> {
  int _position = 0;

  Future<bool> _requestPop() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
    return Future.value(false);
  }

  final controller = PageController();

  List<IntroModel> introModelList = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    introModelList = DataFile.getIntroModel(context);

    double defMargin = getScreenPercentSize(context, 2);
    double radius = getScreenPercentSize(context, 3);
    double firstHeight = getScreenPercentSize(context, 55);
    setState(() {});

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: firstHeight),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(radius),
                        topLeft: Radius.circular(radius),
                      ),
                    ),
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.03),
                  )
                ],
              ),
              Container(
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (context, position) {
                    return Container(
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            height: firstHeight,
                            padding: EdgeInsets.all(
                              getScreenPercentSize(context, 10),
                            ),
                            child: Image.asset(introModelList[position].image!),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: firstHeight),
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.03),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(defMargin),
                                  child: getCustomText(
                                      introModelList[position].name!,
                                      Colors.white,
                                      1,
                                      TextAlign.start,
                                      FontWeight.bold,
                                      25),
                                ),
                                getCustomText(
                                    introModelList[position].desc!,
                                    Colors.white70,
                                    3,
                                    TextAlign.center,
                                    FontWeight.w500,
                                    ConstantData.font18Px),
                                Expanded(child: Container()),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: introModelList.length,
                  onPageChanged: _onPageViewChange,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: firstHeight),
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: Container()),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: defMargin * 1.5),
                        child: InkWell(
                          child: Container(
                            height: getScreenPercentSize(context, 6.5),
                            margin: EdgeInsets.only(bottom: (defMargin)),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: statusBar,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  (defMargin / 2),
                                ),
                              ),
                            ),
                            child: InkWell(
                              child: Center(
                                child: getCustomTextWithoutAlign(
                                    'Next',
                                    Colors.white,
                                    FontWeight.w800,
                                    ConstantData.font18Px),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (_position < (introModelList.length - 1)) {
                              _position++; // position = 1
                              controller.jumpToPage(_position);
                              setState(() {});
                            } else {
                              PrefData.setIsFirstTime(1);
                              Navigator.of(context).pop(true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginHomePage(),
                                ),
                              );
                            }
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: introModelList.map((url) {
                          int index = introModelList.indexOf(url);
                          return Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 5.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _position == index
                                  ? statusBar
                                  : disableIconColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onWillPop: _requestPop);
  }

  _onPageViewChange(int page) {
    _position = page;
    setState(() {});
  }
}
