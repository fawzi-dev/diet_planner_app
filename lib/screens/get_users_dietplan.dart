
import 'package:diet_planner_app/models/api_calls.dart';
import 'package:diet_planner_app/models/daily_plans_models.dart';
import 'package:flutter/material.dart';

class UserDietPlan extends StatefulWidget {
  const UserDietPlan({Key? key, required this.dailyPlans}) : super(key: key);
  final DailyPlans dailyPlans;

  @override
  State<UserDietPlan> createState() => _UserDietPlanState();
}

class _UserDietPlanState extends State<UserDietPlan> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    
  }

  getData() {
    var myObj = widget.dailyPlans.week!.friday;
    var calo  = myObj!.nutrients!.carbohydrates;
    debugPrint('Nurtrints '+calo.toString());
    myObj.meals!.map(
          (e) => debugPrint(
            'ID :::::: ' + e.title.toString(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // child: PageView.builder(itemBuilder: ((context, index) => )),
        );
  }
}
