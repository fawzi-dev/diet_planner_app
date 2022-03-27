import 'package:diet_planner_app/models/daily_plans_models.dart';
import 'package:diet_planner_app/screens/first_page.dart';
import 'package:diet_planner_app/screens/home_screen.dart';
import 'package:diet_planner_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'constants/colors.dart';
import 'models/api_calls.dart';
import 'package:provider/provider.dart';

import 'utils/pref_data.dart';

bool? isCreatePlan = true;
double? calorie;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: statusBar, systemNavigationBarColor: statusBar),
  );
  WidgetsFlutterBinding.ensureInitialized();


  // Intializing SharedPreference & and getting data
   await PrefData.init();
  isCreatePlan = PrefData.getIsCreatePlan();
  // END ________________________________________________________

  // If user already input their data will direct them to the homescreen
  calorie = PrefData.getCalorie() ?? 0;
  DailyPlans dailyPlans = await ApiService.instance
      .generateMealsPlans(targetCalories: calorie!.round());

  /// Get users specified screen
  getClass() {
    if (isCreatePlan == false) {
      return HomeScreen(dailyPlans: dailyPlans);
    } else {
      return const FirstPage();
    }
  }
  ///  END OF THE METHOD -------------------------------------

  

  /// RUN METHOD
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginHomePage(),
      theme: ThemeData(colorSchemeSeed: statusBar),
    ),
  );
}


// //
// class HomeMain extends StatefulWidget {
//   const HomeMain({Key? key}) : super(key: key);

//   @override
//   State<HomeMain> createState() => _HomeMainState();
// }

// class _HomeMainState extends State<HomeMain> {
  

//   @override
//   void initState() {
//     // ignore: todo
//     // TODO: implement initState
//     super.initState();
    
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      ,
      // body: ,
//     );
//   }
// }
