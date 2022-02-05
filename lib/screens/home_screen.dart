import 'package:diet_planner_app/assets/colors.dart';
import 'package:diet_planner_app/assets/text_styles.dart';
import 'package:diet_planner_app/meal_times.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MealsTime> mealTime = [
    MealsTime(
        title: 'Breakfast',
        subtitle: '283 kCal',
        imgPath: 'assets/meals/breakfast.svg'),
    MealsTime(
        title: 'Snack',
        subtitle: '183 kCal',
        imgPath: 'assets/meals/snack1.svg'),
    MealsTime(
        title: 'Lunch',
        subtitle: '583 kCal',
        imgPath: 'assets/meals/lunch.svg'),
    MealsTime(
        title: 'Snack',
        subtitle: '383 kCal',
        imgPath: 'assets/meals/snack2.svg'),
    MealsTime(
        title: 'Dinner',
        subtitle: '383 kCal',
        imgPath: 'assets/meals/dinner.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) => SizedBox(
            child: Column(
              children: [
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Flexible(
                        child: SfRadialGauge(axes: [
                          RadialAxis(
                            showTicks: false,
                            minimum: 0,
                            maximum: 2008.7,
                            showLabels: false,
                            startAngle: 180,
                            endAngle: 0,
                            radiusFactor: 1.2,
                            canScaleToFit: true,
                            axisLineStyle: const AxisLineStyle(
                              thickness: 0.05,
                              color: Colors.white24,
                              thicknessUnit: GaugeSizeUnit.factor,
                              cornerStyle: CornerStyle.startCurve,
                            ),
                            pointers: const <GaugePointer>[
                              RangePointer(
                                  color: Colors.white,
                                  value: 1007.0,
                                  width: 0.05,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  cornerStyle: CornerStyle.bothCurve)
                            ],
                          ),
                        ]),
                      ),
                      const Text('1739.8',style: gaugeLabel,)
                    ],
                  ),
                  height: constraints.maxHeight * 0.3,
                  decoration: const BoxDecoration(
                    color: statusBar,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/ios_arrow_left.svg',
                            color: const Color(0xB31E1E1E),
                            height: 15,
                            width: 15,
                          ),
                          Text(
                            DateFormat('EE , dd MMM')
                                .format(DateTime.now())
                                .toString(),
                            style: dateAndTime,
                          ),
                          SvgPicture.asset(
                            'assets/icons/ios_arrow_right.svg',
                            height: 15,
                            width: 15,
                          ),
                        ],
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      SizedBox(
                        height: constraints.maxHeight * 0.55,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: mealTime.length,
                          itemBuilder: (ctx, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 8),
                            child: Container(
                              height: constraints.maxHeight * 0.2,
                              width: constraints.maxWidth,
                              decoration: BoxDecoration(
                                color: mealsBoxes,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              constraints.maxWidth * 0.05,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              mealTime[index].imgPath,
                                            ),
                                            SizedBox(
                                              height:
                                                  constraints.maxHeight * 0.01,
                                            ),
                                            Text(
                                              mealTime[index].title,
                                              style: mealTitle,
                                            ),
                                            Text(
                                              mealTime[index].subtitle,
                                              style: mealSub,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.blueAccent,
                                        height: 60,
                                        width: 60,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
