import 'package:diet_planner_app/login_page/login_screen.dart';
import 'package:diet_planner_app/screens/home_screen.dart';
import 'package:diet_planner_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'assets/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: statusBar, systemNavigationBarColor: statusBar),
  );
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: HomeMain()),
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
    if (pageController.hasClients) {
      pageController.animateToPage(
        page,
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
        onTap: (currentPage){
         setState(() {
            page=currentPage;
         });
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
         setState(() {
            page = selectedPage;
         });
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
