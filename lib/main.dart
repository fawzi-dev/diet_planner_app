import 'package:diet_planner_app/login_page/login_screen.dart';
import 'package:diet_planner_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'assets/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: statusBar,systemNavigationBarColor:statusBar),
  );
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginHomePage()
    ),
  );
}
