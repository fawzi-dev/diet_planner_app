import 'package:diet_planner_app/assets/colors.dart';
import 'package:diet_planner_app/assets/screen_size.dart';
import 'package:diet_planner_app/assets/text_styles.dart';
import 'package:diet_planner_app/login_page/login_screen.dart';
import 'package:flutter/material.dart';

const String textDesc =
    'Quisque sit amet sagittis erat. Duis pharetra ornare venenatis. Nulla maximus porta velit ut molestie. Proin quis convallis mauris. In facilisis justo at mi pharetra lobortis. s.';

class PageViewScroller extends StatefulWidget {
  const PageViewScroller({Key? key}) : super(key: key);

  @override
  _PageViewScrollerState createState() => _PageViewScrollerState();
}

class _PageViewScrollerState extends State<PageViewScroller> {
  int _selectedPage = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController();
    super.initState();
  }

  void onChangedPage(int pageNum) {
    setState(
      () {
        _selectedPage = pageNum;
        pageController.animateToPage(pageNum,
            duration: const Duration(
              microseconds: 700,
            ),
            curve: Curves.decelerate);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: pageController,
      onPageChanged: (int page) {
        setState(() {
          _selectedPage = page;
        });
      },
      children: [
        OnBoardinig(
          selectedPage: _selectedPage,
          imgUrl: 'assets/onboarding1.jpg',
          header: 'Best tips for your diet',
          subtitle: textDesc,
        ),
        OnBoardinig(
          selectedPage: _selectedPage,
          imgUrl: 'assets/onboarding2.jpg',
          header: 'Feel the changes in a week',
          subtitle: textDesc,
        ),
        OnBoardinig(
          selectedPage: _selectedPage,
          imgUrl: 'assets/onboarding1.jpg',
          header: '',
          subtitle: textDesc,
        )
      ],
    );
  }
}

class OnBoardinig extends StatelessWidget {
  const OnBoardinig(
      {Key? key,
      required this.selectedPage,
      required this.imgUrl,
      required this.header,
      required this.subtitle})
      : super(key: key);

  final int selectedPage;
  final String imgUrl;
  final String header;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image holder in onbaording screen
        SizedBox(
          height: deviceScreenHeight(context) * 0.65,
          width: deviceScreenWidth(context),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.elliptical(150, 40),
              bottomRight: Radius.elliptical(150, 40),
            ),
            child: Image.asset(
              imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: deviceScreenHeight(context) * 0.32,
            width: deviceScreenWidth(context),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Indicator(
                        pageNumber: 0,
                        selectedPage: selectedPage,
                      ),
                      Indicator(
                        pageNumber: 1,
                        selectedPage: selectedPage,
                      ),
                      Indicator(
                        pageNumber: 2,
                        selectedPage: selectedPage,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Best tips for your diet',
                      style: onboardtextStyle,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      textDesc,
                      style: onboardSubtextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Skip this step',
                          style: skipStyle,
                        ),
                        selectedPage == 2
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => const LoginHomePage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  child: const Center(
                                      child: Text(
                                    'Next',
                                    style: buttonStyle,
                                  )),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: statusBar),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator(
      {Key? key, required this.selectedPage, required this.pageNumber})
      : super(key: key);

  final int selectedPage;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
      child: Container(
        height: 7,
        width: 7,
        decoration: BoxDecoration(
          color: selectedPage == pageNumber
              ? Colors.green
              : Colors.grey.withOpacity(0.6),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
