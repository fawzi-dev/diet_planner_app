import 'dart:io';
import 'package:diet_planner_app/screens/first_page.dart';
import 'package:diet_planner_app/screens/login_screen.dart';
import 'package:diet_planner_app/utils/pref_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import '../models/google_auth.dart';
import '../utils/colors.dart';
import '../utils/constant_data.dart';
import '../utils/constant_widget.dart';
import '../utils/size_config.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePage createState() {
    return _EditProfilePage();
  }
}

class _EditProfilePage extends State<EditProfilePage> {
  late String name; // Anony
  var user; // Gmail

  @override
  void initState() {
    name = '';
    super.initState();
    name = PrefData.getIsAnony() ?? '';
    user = FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double topMargin = getScreenPercentSize(context, 1);

    double profileHeight = getScreenPercentSize(context, 17);
    double defaultMargin = getScreenPercentSize(context, 2);

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: getPrimaryAppBarText(context, 'Profile'),
            backgroundColor: statusBar,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                children: [
                  ListView(
                    primary: true,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: (topMargin * 5)),
                        child: Container(
                            height: profileHeight + (profileHeight / 6),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: profileHeight,
                                width: profileHeight,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: statusBar,
                                    width: getScreenPercentSize(context, 0.25),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipOval(
                                    child: Material(
                                      color: statusBar,
                                      child: user != null
                                          ? Image.network(
                                              user!.photoURL!,
                                              fit: BoxFit.cover,
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(22.0),
                                              child: SvgPicture.asset(
                                                'assets/anony.svg',
                                                height: 24,
                                                width: 24,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      user != null
                          ? getBoldTextWidget(
                              user!.displayName!,
                              Colors.black45,
                              TextAlign.center,
                              FontWeight.w600,
                              constraints.maxHeight * 0.05)
                      // if(...){....} else{...}
                          : getBoldTextWidget(
                              name,
                              Colors.black45,
                              TextAlign.center,
                              FontWeight.w600,
                              constraints.maxHeight * 0.05),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: defaultMargin),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                getScreenPercentSize(context, 4)),
                            topRight: Radius.circular(
                              getScreenPercentSize(context, 4),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.all(defaultMargin),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => FirstPage(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 8),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: mealsBoxes,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 10),
                                      Icon(Icons.refresh_rounded,
                                          color: primaryColor,
                                          size: constraints.maxHeight * 0.05),
                                      const SizedBox(width: 5),
                                      getCustomText(
                                          'Reset Plan',
                                          Colors.black87,
                                          1,
                                          TextAlign.center,
                                          FontWeight.w400,
                                          constraints.maxHeight * 0.03)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                PrefData.setIsFirstTime(1);
                                setState(() {});
                                final provider = Provider.of<GoogleLoginClass>(
                                    context,
                                    listen: false);
                                provider.googleLogOut();

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => LoginHomePage(
                                        key: UniqueKey(),
                                      ),
                                    ),
                                    (Route<dynamic> route) => false);
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 8),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: mealsBoxes,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 13),
                                      Icon(Icons.logout_rounded,
                                          color: primaryColor,
                                          size: constraints.maxHeight * 0.05),
                                      const SizedBox(width: 5),
                                      getCustomText(
                                          'Log out',
                                          Colors.black87,
                                          1,
                                          TextAlign.center,
                                          FontWeight.w400,
                                          constraints.maxHeight * 0.03)
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: defaultMargin,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
