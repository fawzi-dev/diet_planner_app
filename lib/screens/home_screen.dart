import 'package:diet_planner_app/constants/colors.dart';
import 'package:diet_planner_app/constants/text_styles.dart';
import 'package:diet_planner_app/meal_times.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                      SfRadialGauge(axes: [
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
                                value: 1739.8,
                                width: 0.05,
                                sizeUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.bothCurve)
                          ],
                        ),
                      ]),
                      const Text(
                        '1739.8 \n kCal left',
                        style: gaugeLabel,
                      )
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
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            MealsWidget(
                              constraints: constraints,
                              title: 'Breakfast',
                              subtitle: 283,
                              imgPath: 'assets/meals/breakfast.svg',
                            ),
                            MealsWidget(
                                constraints: constraints,
                                title: 'Lunch',
                                subtitle: 583,
                                imgPath: 'assets/meals/lunch.svg'),
                            MealsWidget(
                                constraints: constraints,
                                title: 'Dinner',
                                subtitle: 383,
                                imgPath: 'assets/meals/dinner.svg'),
                          ],
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

class MealsWidget extends StatelessWidget {
  const MealsWidget({
    Key? key,
    required this.constraints,
    required this.title,
    required this.imgPath,
    required this.subtitle,
  }) : super(key: key);

  final BoxConstraints constraints;
  final String title;
  final String imgPath;
  final double subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
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
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        imgPath,
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
                      ),
                      Text(
                        title,
                        style: mealTitle,
                      ),
                      Text(
                        '$subtitle kCal',
                        style: mealSub,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0,bottom:12.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor:mealBoxAddButtonColor,
                      child: IconButton(
                        icon: SvgPicture.asset('assets/icon_plus.svg'),
                        onPressed: () {},
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
