import 'dart:io';

import 'package:diet_planner_app/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import '../models/IntroModel.dart';
import '../utils/ConstantData.dart';
import '../utils/ConstantWidget.dart';
import '../utils/DataFile.dart';
import '../utils/PrefData.dart';
import '../utils/SizeConfig.dart';

class IntroPage extends StatefulWidget {
  // final ValueChanged<bool> onChanged;

  // IntroPage(this.onChanged);

  @override
  _IntroPage createState() {
    return _IntroPage();
    // return _IntroPage(this.onChanged);
  }
}

class _IntroPage extends State<IntroPage> {
  int _position = 0;

  // final ValueChanged<bool> onChanged;

  // _IntroPage(this.onChanged);

  Future<bool> _requestPop() {
    //   Future.delayed(const Duration(milliseconds: 200), () {
    //     SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    //   });

    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }

    return new Future.value(false);
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
                    height: firstHeight,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: firstHeight),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(radius),
                            topLeft: Radius.circular(radius))),
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(child: Container()),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: defMargin * 1.5),
                            child: InkWell(
                              child: Container(
                                  height: getScreenPercentSize(context, 6.5),
                                  margin: EdgeInsets.only(bottom: (defMargin)),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular((defMargin / 2)))),
                                  child: InkWell(
                                    child: Center(
                                      child: getCustomTextWithoutAlign(
                                          'Next',
                                          Colors.white,
                                          FontWeight.w900,
                                          ConstantData.font18Px),
                                    ),
                                  )),
                              onTap: () {
                                if (_position < (introModelList.length - 1)) {
                                  _position++;
                                  controller.jumpToPage(_position);
                                  setState(() {});
                                } else {
                                  PrefData.setIsIntro(false);
                                  Navigator.of(context).pop(true);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
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
                                      ? Colors.orange
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
                                getScreenPercentSize(context, 10)),
                            // decoration: BoxDecoration(

                            // color: Colors.black,
                            // image: DecorationImage(
                            //   // colorFilter: new ColorFilter.mode(
                            //   //     Colors.black.withOpacity(0.5),
                            //   //     BlendMode.dstATop),
                            //   image: ExactAssetImage(
                            //       introModelList[position].image!),
                            //   fit: BoxFit.cover,
                            // ),
                            // ),

                            child: Image.asset(introModelList[position].image!),
                          ),
                          // Align(
                          //   alignment: Alignment.bottomCenter,
                          //   child: Container(
                          //     width: double.infinity,
                          //
                          //     height: getScreenPercentSize(context, 70),
                          //     decoration: BoxDecoration(
                          //         gradient: LinearGradient(colors: [
                          //       Colors.white,
                          //       Colors.white,
                          //       Colors.white70,
                          //       Colors.white60,
                          //       Colors.white54,
                          //       Colors.white38,
                          //       Colors.white38,
                          //       Colors.white10,
                          //       Colors.transparent
                          //     ], end: const Alignment(0.0, -1),
                          //           begin: const Alignment(0.0, 0.6), )),
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: firstHeight),

                            // decoration: BoxDecoration(
                            //   color: primaryColor,
                            //   borderRadius: BorderRadius.only(topRight: Radius.circular(radius),topLeft: Radius.circular(radius))
                            // ),
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.03),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Container(
                                //   height: imageSize,
                                // ),
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
                              )),
                          onTap: () {
                            if (_position < (introModelList.length - 1)) {
                              _position++;
                              controller.jumpToPage(_position);
                              setState(() {});
                            } else {
                              PrefData.setIsIntro(false);
                              Navigator.of(context).pop(true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
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
