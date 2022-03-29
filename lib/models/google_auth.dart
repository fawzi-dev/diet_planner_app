import 'package:diet_planner_app/screens/first_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginClass extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  late GoogleSignInAccount _user;

  GoogleSignInAccount get user => _user;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }

  Future loginButtonClicked() async {
    final LoginResult loginResult = await FacebookAuth.i.login(permissions: ['email']);
    if(loginResult.status == LoginStatus.success){
      final AccessToken accessToken = loginResult.accessToken!;
      final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
      final user = await  FacebookAuth.i.getUserData();
      print(user);

    }
    else if(loginResult.status == LoginStatus.cancelled){
      return ;
    }
    else{
      return ;
    }
  }

  Future facebookLogot() async {
       await FacebookAuth.instance.logOut();
       notifyListeners();
  }

  Future googleLogOut() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}


class FacebookUserInfo {
  String? name;
  String? email;
  Picture? picture;
  String? id;

  FacebookUserInfo({this.name, this.email, this.picture, this.id});

  FacebookUserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    picture =
        json['picture'] != null ? Picture.fromJson(json['picture']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    if (picture != null) {
      data['picture'] = picture!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class Picture {
  Data? data;

  Picture({this.data});

  Picture.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? height;
  String? url;
  int? width;

  Data({this.height, this.url, this.width});

  Data.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['url'] = url;
    data['width'] = width;
    return data;
  }
}
