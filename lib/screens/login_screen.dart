import 'package:diet_planner_app/models/google_auth.dart';
import 'package:diet_planner_app/screens/first_page.dart';
import 'package:diet_planner_app/utils/pref_data.dart';
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
  bool obscuredText = true;

  late String isGoogle;

  @override
  void initState() {
    isGoogle = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('The value of boolean is : ' + obscuredText.toString());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.green.shade100.withOpacity(0.3),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PrefData.setIsFirstTime(2);
            PrefData.setIsGoogle(true);
            return const FirstPage();
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
                  width: deviceScreenWidth(context) * 9,
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
                              final provider = Provider.of<GoogleLoginClass>(
                                  context,
                                  listen: false);
                              provider.loginButtonClicked();
                            },
                            imgUrl: 'assets/face.svg',
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          OtherSignInOption(
                            onTap: () {
                              final provider = Provider.of<GoogleLoginClass>(
                                  context,
                                  listen: false);
                              provider.googleLogin();
                              setState(() {});
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

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Don\'t have an account? '),
          Text(
            'Sign Up',
            style: signUp,
          )
        ],
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



// class TextInputs extends StatefulWidget {
//   const TextInputs({
//     Key? key,
//     required this.title,
//     required this.icon,
//     required this.isOn,
//     required this.iconColor,
//     required this.onTap,
//     required this.obscureText,
//   }) : super(key: key);

//   final String title;
//   final IconData icon;
//   final bool isOn;
//   final Color iconColor;
//   final VoidCallback onTap;
//   final bool obscureText;

//   @override
//   State<TextInputs> createState() => _TextInputsState();
// }

// class _TextInputsState extends State<TextInputs> with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation animation;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     animationController = AnimationController(
//         vsync: this,
//         duration: const Duration(milliseconds: 800),
//         lowerBound: 0.0,
//         upperBound: 1.0);

//     animation = CurvedAnimation(parent: animationController, curve: Curves.decelerate);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     animationController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       shadowColor: Colors.blueAccent.withOpacity(0.1),
//       elevation: 2.5,
//       borderRadius: BorderRadius.circular(10),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           color: Colors.white,
//           height: deviceScreenHeight(context) * 0.08,
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             children: [
//               Flexible(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: widget.title,
//                     hintStyle: hintText,
//                     fillColor: Colors.white,
//                     filled: true,
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none),
//                     contentPadding: const EdgeInsets.only(left: 10, bottom: 2),
//                   ),
//                   cursorColor: Colors.green,
//                   style: inputText,
//                   textAlign: TextAlign.left,
//                   cursorHeight: 25,
//                   obscureText: widget.obscureText,
//                   onChanged: (theText) {
//                     if (theText.length > 5) {
//                       setState(() {
//                         animationController.forward();
//                         animationController.addListener(() {});
//                       });
//                     } else if (theText.isEmpty) {
//                       setState(() {
//                         animationController.reset();
//                         animationController.addListener(() {});
//                       });
//                     }
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 12.0),
//                 child: GestureDetector(
//                   onTap: widget.onTap,
//                   child: ClipRRect(
//                     borderRadius: widget.icon == Icons.check
//                         ? BorderRadius.circular(60)
//                         : BorderRadius.circular(0.0),
//                     child: Container(
//                       alignment: Alignment.center,
//                       height: 20,
//                       width: widget.icon == Icons.check ? 20 : 25,
//                       padding: const EdgeInsets.all(2),
//                       color: widget.isOn
//                           ? iconCheck.withOpacity(animation.value)
//                           : Colors.transparent,
//                       child: Icon(
//                         widget.icon,
//                         color: widget.iconColor,
//                         /// Check = 14 || eyes = 18
//                         size: widget.icon == Icons.check ? 14 : 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// TextInputs(
                  //   title: 'Username',
                  //   icon: Icons.check,
                  //   isOn: true,
                  //   iconColor: Colors.white,
                  //   onTap: () {},
                  //   obscureText: false,
                  // ),
                  // TextInputs(
                  //   title: 'Password',
                  //   icon: Icons.remove_red_eye,
                  //   isOn: false,
                  //   iconColor: Colors.grey,
                  //   onTap: () {
                  //     setState(() {
                  //       // true = false
                  //       obscuredText = !obscuredText;
                  //     });
                  //   },
                  //   obscureText: obscuredText,
                  // ),
                  // const Text('Forget your password?'),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: InkWell(
                  //         borderRadius:
                  //             BorderRadius.circular(constraints.maxHeight * 0.02),
                  //         onTap: () {},
                  //         splashColor: Colors.white54,
                  //         child: Ink(
                  //           decoration: BoxDecoration(
                  //             color: loginButton,
                  //             borderRadius: BorderRadius.circular(
                  //                 constraints.maxHeight * 0.02),
                  //           ),
                  //           height: constraints.maxHeight * 0.095,
                  //           child: const Center(
                  //             child: FittedBox(
                  //               child: Text(
                  //                 'Login',
                  //                 style: loginText,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // const SignUpButton(),