import 'package:diet_planner_app/screens/first_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginClass extends ChangeNotifier {

  // Creating an instance of google sign in
  final googleSignIn = GoogleSignIn();
  
  // initializing a late var of Google user
  late GoogleSignInAccount _user;

  // Get and set for user
  GoogleSignInAccount get user => _user;

  // an async method to get user's gmail info and save it into our google user variable
  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    // Notifying parent widget that child widget has changed
    notifyListeners();
  }



  // a future void to sign out user 
  Future googleLogOut() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}

