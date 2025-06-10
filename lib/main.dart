import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_foam/assigmentwidget/splash.dart';

import 'my_main_screen/choose.dart';

const firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyAfbY3LSkmostNFBJgtI4JmjELWDtdPfqM",
  authDomain: "first-project-ca9e5.firebaseapp.com",
  projectId: "first-project-ca9e5",
  storageBucket: "first-project-ca9e5.firebasestorage.app",
  messagingSenderId: "638658007004",
  appId: "1:638658007004:web:2269971b0a75dc6e5ac919",
  measurementId: "G-L2FEJ31KM2",
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: firebaseOptions, // Must provide options for web!
    );
  } else {
    await Firebase.initializeApp(); // For Android/iOS, no options needed here.
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Start ",
      home: splashscreen()
    );

  }
}
