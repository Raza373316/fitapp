import 'package:flutter/material.dart';
import 'package:login_foam/firebaseservies/splashservies.dart';
class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  splashservies splashscreen = splashservies();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          SizedBox.expand(
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                'assets/image/two.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Optional: Overlay text or widgets on top of the image
          Center(
            child: Text(
              "Welcome to My Fitness App",
              style: TextStyle(
                fontSize: 30,
                color: Colors.teal,
                fontWeight: FontWeight.w100,

              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}