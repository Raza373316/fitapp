import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:login_foam/my_main_screen/choose.dart';


import 'package:login_foam/textfeild/signup.dart';

class splashservies {
  void islogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => Chosescreen())));
    } else {
      Timer(
        Duration(seconds: 3),
          ()=>Navigator.push(context,
          MaterialPageRoute(builder:(context)=>SignUpScreens())));
    }
  }
}
