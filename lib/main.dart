import 'package:diet_planner_app/login_page/login_screen.dart';
import 'package:diet_planner_app/screens/IntroPage.dart';
import 'package:diet_planner_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'constants/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: statusBar, systemNavigationBarColor: statusBar),
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeMain(),
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

  @override
  Widget build(BuildContext context) {
    debugPrint(page.toString());
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: statusBar,
        onTap: (currentPage) {
          animateToPageMethod(currentPage);
          setState(() {});
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
          HomeScreen(),
        ],
      ),
    );
  }
}
