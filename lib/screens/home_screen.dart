import 'package:diet_planner_app/constants/colors.dart';
import 'package:diet_planner_app/constants/text_styles.dart';
import 'package:diet_planner_app/models/daily_plans_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../constants/colors.dart';

double trackCalorie = 0.0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.dailyPlans}) : super(key: key);

  final DailyPlans? dailyPlans;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<double> calories = [
      widget.dailyPlans!.week!.friday!.nutrients!.calories!,
      widget.dailyPlans!.week!.saturday!.nutrients!.calories!,
      widget.dailyPlans!.week!.sunday!.nutrients!.calories!,
      widget.dailyPlans!.week!.monday!.nutrients!.calories!,
      widget.dailyPlans!.week!.tuesday!.nutrients!.calories!,
      widget.dailyPlans!.week!.wednesday!.nutrients!.calories!,
      widget.dailyPlans!.week!.thursday!.nutrients!.calories!,
    ];

    List<double> fat = [
      widget.dailyPlans!.week!.friday!.nutrients!.fat!,
      widget.dailyPlans!.week!.saturday!.nutrients!.fat!,
      widget.dailyPlans!.week!.sunday!.nutrients!.fat!,
      widget.dailyPlans!.week!.monday!.nutrients!.fat!,
      widget.dailyPlans!.week!.tuesday!.nutrients!.fat!,
      widget.dailyPlans!.week!.wednesday!.nutrients!.fat!,
      widget.dailyPlans!.week!.thursday!.nutrients!.fat!,
    ];

    List<double> protein = [
      widget.dailyPlans!.week!.friday!.nutrients!.protein!,
      widget.dailyPlans!.week!.saturday!.nutrients!.protein!,
      widget.dailyPlans!.week!.sunday!.nutrients!.protein!,
      widget.dailyPlans!.week!.monday!.nutrients!.protein!,
      widget.dailyPlans!.week!.tuesday!.nutrients!.protein!,
      widget.dailyPlans!.week!.wednesday!.nutrients!.protein!,
      widget.dailyPlans!.week!.thursday!.nutrients!.protein!,
    ];

    List<double> carbo = [
      widget.dailyPlans!.week!.friday!.nutrients!.carbohydrates!,
      widget.dailyPlans!.week!.saturday!.nutrients!.carbohydrates!,
      widget.dailyPlans!.week!.sunday!.nutrients!.carbohydrates!,
      widget.dailyPlans!.week!.monday!.nutrients!.carbohydrates!,
      widget.dailyPlans!.week!.tuesday!.nutrients!.carbohydrates!,
      widget.dailyPlans!.week!.wednesday!.nutrients!.carbohydrates!,
      widget.dailyPlans!.week!.thursday!.nutrients!.carbohydrates!,
    ];

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) => SizedBox(
            child: PageView.builder(
              itemCount: 7,
              itemBuilder: (ctx, index) => Column(
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SfRadialGauge(axes: [
                          RadialAxis(
                            showTicks: false,
                            minimum: 0,
                            maximum: calories[index],
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
                            pointers: <GaugePointer>[
                              RangePointer(
                                  color: Colors.white,
                                  value: trackCalorie,
                                  width: 0.05,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  cornerStyle: CornerStyle.bothCurve)
                            ],
                          ),
                        ]),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${calories[index].round()}',
                                style: gaugeLabel),
                            Text('kcal left', style: gaugeLabelSub),
                            SizedBox(height: constraints.maxHeight * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                UserInfo(
                                  index: index,
                                  info: fat,
                                  label: 'Fat',
                                  color: Colors.amber,
                                ),
                                UserInfo(
                                    index: index,
                                    info: protein,
                                    label: 'Protein',
                                    color: Colors.redAccent),
                                UserInfo(
                                    index: index,
                                    info: carbo,
                                    label: 'Carbo',
                                    color: Colors.lightBlue)
                              ],
                            )
                          ],
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
                              'Day ${index + 1}',
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
                                onTap: () {
                                  trackCalorie += (calories[index] / 3);
                                  setState(() {});
                                  debugPrint(trackCalorie.toString());
                                },
                                constraints: constraints,
                                title: 'Breakfast',
                                subtitle: calories[index] / 3,
                                imgPath: 'assets/meals/breakfast.svg',
                              ),
                              MealsWidget(
                                  onTap: () {
                                    if (trackCalorie < calories[index]) {
                                      trackCalorie += (calories[index] / 3);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('That is enough for tday'),
                                        ),
                                      );
                                    }
                                    setState(() {});
                                    debugPrint(trackCalorie.toString());
                                  },
                                  constraints: constraints,
                                  title: 'Lunch',
                                  subtitle: calories[index].round() / 3,
                                  imgPath: 'assets/meals/lunch.svg'),
                              MealsWidget(
                                  onTap: () {
                                    trackCalorie += (calories[index] / 3);
                                    setState(() {});
                                    debugPrint(trackCalorie.toString());
                                  },
                                  constraints: constraints,
                                  title: 'Dinner',
                                  subtitle: calories[index].round() / 3,
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
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo(
      {Key? key, required this.info, this.label, this.color, this.index})
      : super(key: key);

  final List<double> info;
  final String? label;
  final Color? color;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(backgroundColor: color!.withOpacity(0.9), radius: 5),
          const SizedBox(
            width: 5,
          ),
          Text('$label : ${info[index!].round()}', style: theThreeLabels)
        ],
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
    required this.onTap,
  }) : super(key: key);

  final BoxConstraints constraints;
  final String title;
  final String imgPath;
  final double subtitle;
  final VoidCallback onTap;

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
                        '${subtitle.round()} kCal',
                        style: mealSub,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, bottom: 12.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: mealBoxAddButtonColor,
                      child: IconButton(
                        icon: SvgPicture.asset('assets/icon_plus.svg'),
                        onPressed: onTap,
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
