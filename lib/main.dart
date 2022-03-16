import 'package:diet_planner_app/models/daily_plans_models.dart';
import 'package:diet_planner_app/screens/first_page.dart';
import 'package:diet_planner_app/screens/get_users_dietplan.dart';
import 'package:diet_planner_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'constants/colors.dart';
import 'models/api_calls.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: statusBar, systemNavigationBarColor: statusBar),
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FirstPage(),
      theme: ThemeData(colorSchemeSeed: statusBar),
    ),
  );
}

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  PageController pageController = PageController();
  int page = 0;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    animateToPageMethod(page);
  }

  animateToPageMethod(int index) {
    if (pageController.hasClients) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void mealPlans() async {
    DailyPlans dailyPlans =
        await ApiService.instance.generateMealPlan(targetCalories: 3000);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => UserDietPlan(
          dailyPlans: dailyPlans,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(page.toString());
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: statusBar,
        onTap: (currentPage) {
          animateToPageMethod(currentPage);
          setState(() {});
          mealPlans();
        },
        currentIndex: page,
        items: [
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset('assets/navIcon/a-home.svg',
                  color: statusBar),
              icon: SvgPicture.asset('assets/navIcon/home.svg'),
              label: 'Home'),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset('assets/navIcon/a-heart.svg',
                  color: statusBar),
              icon: SvgPicture.asset('assets/navIcon/heart.svg'),
              label: 'Fav'),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset('assets/navIcon/a-foods.svg',
                  color: statusBar),
              icon: SvgPicture.asset('assets/navIcon/foods.svg'),
              label: 'Meals'),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset('assets/navIcon/a-profile.svg',
                  color: statusBar),
              icon: SvgPicture.asset('assets/navIcon/profile.svg'),
              label: 'Profile')
        ],
      ),
      body: PageView(
        onPageChanged: (selectedPage) {
          page = selectedPage;
          setState(() {});
        },
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: const [
          HomeScreen(),
        ],
      ),
    );
  }
}
