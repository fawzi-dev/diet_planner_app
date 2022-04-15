import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diet_planner_app/models/daily_plans_models.dart';
import 'package:diet_planner_app/models/google_auth.dart';
import 'package:diet_planner_app/models/intro_model.dart';
import 'package:diet_planner_app/screens/first_page.dart';
import 'package:diet_planner_app/screens/home_screen.dart';
import 'package:diet_planner_app/screens/intro_page.dart';
import 'package:diet_planner_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'models/api_calls.dart';

import 'utils/colors.dart';
import 'utils/pref_data.dart';

// bool? isCreatePlan = true;
// bool? isSignedIn;
int? isFirstPage;
// bool? isIntro;
double? calorie;

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: statusBar, systemNavigationBarColor: statusBar),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();

  // Intializing SharedPreference & and getting data
  await PrefData.init();
  isFirstPage = PrefData.getIsFirstTime() ?? 0;
  // END ________________________________________________________

  // If user already input their data will direct them to the homescreen
  calorie = PrefData.getCalorie() ?? 0.0;
  DailyPlans? dailyPlans = await ApiService.instance
      .generateMealsPlans(targetCalories: calorie!.round());

  /// Get users specified screen
  getClass() {
    if (isFirstPage == 0) {
      return IntroPage();
    } else if (isFirstPage == 1) {
      return const LoginHomePage();
    } else if (isFirstPage == 2) {
      return FirstPage();
    } else if (isFirstPage == 3) {
      return HomeScreen(dailyPlans: dailyPlans);
    }
  }

  ///  END OF THE METHOD -------------------------------------

  /// RUN METHOD
  runApp(
    ChangeNotifierProvider(
      create: (context) => GoogleLoginClass(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // ignore: unrelated_type_equality_checks
        home: getClass(),
        theme: ThemeData(colorSchemeSeed: statusBar),
      ),
    ),
  );
}

