import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class utils{
  void toastmassage(String massage){
    Fluttertoast.showToast(msg: massage,
    toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
     timeInSecForIosWeb: (6),
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 20,


    );

  }
}