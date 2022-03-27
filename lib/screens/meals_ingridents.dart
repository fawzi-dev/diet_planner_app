import 'package:diet_planner_app/models/api_calls.dart';
import 'package:diet_planner_app/models/ingredients.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../utils/constant_data.dart';
import '../utils/constant_widget.dart';

class DishDetailPage extends StatefulWidget {
  // final DishModel dishModel;

  final int id;
  final double protein;
  final double carbo;
  final double fat;
  final String appBarTitle;

  const DishDetailPage(
      {Key? key,
      required this.id,
      required this.protein,
      required this.carbo,
      required this.fat,required this.appBarTitle})
      : super(key: key);

  @override
  _DishDetailPage createState() {
    return _DishDetailPage();
  }
}

class _DishDetailPage extends State<DishDetailPage> {
  void onBackClick() {
    Navigator.of(context).pop();
  }

  // late String img;
  late List<String>? name;
  late List<String>? unit;
  late List<double>? value;

  getIngrident() async {
    Ingredients ingredients;
    ingredients = await ApiService.instance.getIngridents(id: widget.id);
    for (var element in ingredients.ingredients!) {
      //img = element.image!;
      name!.add(element.name!);
      unit!.add(element.amount!.metric!.unit!);
      value!.add(element.amount!.metric!.value!);
      // getList(name!);
      // amountUnit = element.amount!.metric!.unit!;
    }
    setState(() {});
  }

  @override
  void initState() {
    //img = '';
    name = [];
    unit = [];
    value = [];
    super.initState();
    getIngrident();
  }

  @override
  Widget build(BuildContext context) {
    double margin = getScreenPercentSize(context, 2);
    double height = getScreenPercentSize(context, 30);
    double horizontalMargin = getScreenPercentSize(context, 3.5);
    double viewHeight = getScreenPercentSize(context, 12);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: getPrimaryAppBarText(context, widget.appBarTitle),
            backgroundColor: primaryColor,
            centerTitle: false,
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: getPrimaryAppBarIcon(),
                  onPressed: onBackClick,
                );
              },
            ),
          ),
          body: SafeArea(
            child: Container(
              color: cellColor,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                getPercentSize(viewHeight, 8),
                              ),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: getPercentSize(viewHeight, 5),
                                vertical: getPercentSize(viewHeight, 3)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                getCell(viewHeight, Colors.redAccent, "Protein",
                                    widget.protein.round().toString()),
                                Container(
                                  height: getPercentSize(viewHeight, 35),
                                  color: textColor,
                                  width: 1,
                                ),
                                getCell(viewHeight, Colors.amber, "Fat",
                                    widget.fat.round().toString()),
                                Container(
                                  height: getPercentSize(viewHeight, 35),
                                  color: textColor,
                                  width: 1,
                                ),
                                getCell(viewHeight, Colors.blueAccent, "Carbs",
                                    widget.carbo.round().toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: getPercentSize(height, 25),
                        ),
                        decoration: BoxDecoration(
                          color: cellColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              getScreenPercentSize(context, 4),
                            ),
                            topRight: Radius.circular(
                              getScreenPercentSize(context, 4),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(margin),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getTitle("Ingredients"),
                                  getList(name!, unit!, value!),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: margin,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          onBackClick();
          return false;
        });
  }

  getList(List<String> list, List<String> unit, List<double> value) {
    double margin = getScreenPercentSize(context, 2);
    double size = getScreenPercentSize(context, 1);
    // double size = getScreenPercentSize(context, 2.8);

    return
        // Card(
        //   color: cellColor,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(7),
        //   ),
        //   child:

        ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: (margin / 2)),
      // padding: EdgeInsets.symmetric(vertical: (margin / 2)),
      itemCount: list.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: margin / 2),
          child: Row(
            children: [
              Container(
                height: size,
                width: size,
                margin: EdgeInsets.only(right: margin),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: primaryColor),
              ),
              Expanded(
                  child: getRobotoTextWidget(
                      value[index].toStringAsFixed(1) + ' ' + unit[index] + ' ',
                      textColor.withOpacity(0.6),
                      TextAlign.start,
                      FontWeight.w500,
                      getScreenPercentSize(context, 2.2))),
              Expanded(
                  child: getRobotoTextWidget(
                      list[index],
                      textColor,
                      TextAlign.start,
                      FontWeight.w900,
                      getScreenPercentSize(context, 2.2)))
            ],
          ),
        );
      },
    );
    // )
  }

  getTitle(String s) {
    double margin = getScreenPercentSize(context, 1.5);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: getScreenPercentSize(context, 0.5)),
            child: Text(
              s,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: getScreenPercentSize(context, 2.5),
                  color: textColor,
                  fontFamily: ConstantData.fontFamily,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            height: getScreenPercentSize(context, 0.5),
            width: getWidthPercentSize(context, 10),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(getScreenPercentSize(context, 0.5)))),
          )
        ],
      ),
    );
  }

  getCell(double height, Color color, String s, String s1) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: color,
                size: getPercentSize(height, 10),
              ),

              SizedBox(
                width: getWidthPercentSize(context, 1),
              ),
              // Expanded(
              //   child:
              getTextWidget(s, subTextColor, TextAlign.start, FontWeight.w600,
                  getPercentSize(height, 14)),
              // )
            ],
          ),
          // Expanded(
          //   child:
          getTextWidget(s1, textColor, TextAlign.center, FontWeight.bold,
              getPercentSize(height, 16)),
          // )
        ],
      ),
    );
  }
}
