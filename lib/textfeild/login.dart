import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_foam/assigmentwidget/confirm_password_widget.dart';
import 'package:login_foam/my_main_screen/choose.dart';

import 'package:login_foam/textfeild/signup.dart';
import 'package:login_foam/my_main_screen/choose.dart';
import '../utils/util.dart';

class myAppScreen extends StatefulWidget {
  const myAppScreen({super.key});

  @override
  State<myAppScreen> createState() => _myAppScreenState();
}

class _myAppScreenState extends State<myAppScreen> {
  final formKey = GlobalKey<FormState>();
  final _auth=FirebaseAuth.instance;
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passcontroller=TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.7,
              child: Image.asset('assets/image/fit.jpg',
                fit: BoxFit.cover,
              ),
            ),

            Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // SizedBox(height: 40,),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
          
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
          
                  SizedBox(
                    height: 80,
                  ),
          CustomWidget(textEditingController: emailcontroller, labelText: 'Email',
              prefixIcon: Icons.email,
            validatorFunction: (value) {
              if (value == null || value.isEmpty) {
                return 'Email can not be empty';
              }
              if (!value.contains('@')) {
                return 'Invalid email type';
              }
              return null;
            },
          ),

                  SizedBox(height: 10,),
                  CustomWidget(textEditingController: passcontroller,
                      labelText: 'Password',
                      prefixIcon: Icons.password,  isPasswordHidden: isPasswordVisible,
                    suffixIcon: isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },),

          
                  SizedBox(
                    height: 10,
                  ),
          
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: Text('Forgot Password',
                      style: TextStyle(color: Colors.tealAccent),)),
                  ),
          
                  SizedBox(
                    height: 30,
                  ),
          
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _auth.signInWithEmailAndPassword
                            (email: emailcontroller.text, password: passcontroller.text).
                          then((value){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Chosescreen()));
                          })
                              .onError((error,stacktrack){
                            utils().toastmassage(error.toString());
                          });
          
                        }
                      },  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,),

                      child: Text('Login')),
          
                  SizedBox(
                    height: 20,
                  ),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do not have account?',style: TextStyle(color: Colors.teal),),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(

                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreens()));
          
                            print('signup clicked');
                          },
                          child: Text(
                            'Signup',
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
    ],
        ),

    );
  }
}

