import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diet_planner_app/models/google_auth.dart';
import 'package:diet_planner_app/screens/first_page.dart';
import 'package:diet_planner_app/utils/pref_data.dart';
import 'package:diet_planner_app/utils/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import '../utils/screen_size.dart';
import '../utils/text_styles.dart';

final user = FirebaseAuth.instance.currentUser;

class LoginHomePage extends StatelessWidget {
  const LoginHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const [BackGround(), LoginItems()],
    );
  }
}

class BackGround extends StatelessWidget {
  const BackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        decoration: const BoxDecoration(
          color: bgColor,
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class LoginItems extends StatefulWidget {
  const LoginItems({Key? key}) : super(key: key);

  @override
  State<LoginItems> createState() => _LoginItemsState();
}

class _LoginItemsState extends State<LoginItems> {
  @override
  void initState() {

    super.initState();
  }

  Future<void> login() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      final provider = Provider.of<GoogleLoginClass>(context, listen: false);
      provider.googleLogin();
    } else {
      showSnackBar(
          context, 'You are not connected to internet.', Colors.red, true);
    }
    setState(() {});
  }

  loginAsAnony() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      PrefData.setIsFirstTime(2);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => FirstPage(isAnony: true)),
          (route) => false);
    } else {
      showSnackBar(
          context, 'You are not connected to internet.', Colors.red, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.green.shade100.withOpacity(0.3),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PrefData.setIsFirstTime(2);
            return FirstPage(
              isAnony: false,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else {
            return Center(
              child: LayoutBuilder(
                builder: (ctx, constraints) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: deviceScreenHeight(context) * .6,
                  width: deviceScreenWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        child: Text(
                          'Welcome',
                          style: welcomeText,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OtherSignInOption(
                            onTap: () {
                              loginAsAnony();
                            },
                            imgUrl: 'assets/anony.svg',
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          OtherSignInOption(
                            onTap: () {
                              login();
                            },
                            imgUrl: 'assets/google.svg',
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}



// ignore: must_be_immutable
class OtherSignInOption extends StatelessWidget {
  OtherSignInOption({
    Key? key,
    required this.imgUrl,
    required this.onTap,
  }) : super(key: key);

  final String imgUrl;
  final VoidCallback onTap;
  double radius = 20;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white70,
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(20),
        height: deviceScreenHeight(context) * .1,
        width: deviceScreenWidth(context) * .3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            radius,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black26.withOpacity(0.01),
                offset: const Offset(0, 02),
                blurRadius: 15,
                spreadRadius: 10)
          ],
        ),
        child: SvgPicture.asset(imgUrl, alignment: Alignment.center),
      ),
    );
  }
}
