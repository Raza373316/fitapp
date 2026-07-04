import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Thin wrapper around fluttertoast so call sites don't touch the package
/// directly. Kept as a free function (not a class you instantiate) since it
/// holds no state.
void showToast(String message, {bool isError = true}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 4,
    backgroundColor: isError ? Colors.red : Colors.teal,
    textColor: Colors.white,
    fontSize: 16,
  );
}
