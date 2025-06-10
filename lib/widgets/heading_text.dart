import 'package:flutter/material.dart';
class HeadingText extends StatelessWidget {
  final String headingtext;
  final MaterialColor fcolor;
  final double fsize;
  const HeadingText({super.key,
  required this.headingtext,
    this.fsize=43,
  required this.fcolor});


  @override
  Widget build(BuildContext context) {
    return  Text(
      headingtext,
      style: TextStyle(
        fontSize: fsize,
        fontWeight: FontWeight.bold,
        color: fcolor,
      ),
      textAlign: TextAlign.center,
    );
  }
}
