import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_foam/assigmentwidget/confirm_password_widget.dart';
import 'package:login_foam/my_main_screen/choose.dart';

import 'package:login_foam/textfeild/login.dart';
import 'package:login_foam/utils/util.dart';
import 'package:login_foam/widgets/heading_text.dart';
import 'package:login_foam/modal/user.dart';

class SignUpScreens extends StatefulWidget {
  const SignUpScreens({super.key});

  @override
  State<SignUpScreens> createState() => _SignUpScreensState();
}

class _SignUpScreensState extends State<SignUpScreens> {
  FirebaseAuth _auth=FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final nameController = TextEditingController();
  final emailicon = TextEditingController();
  final pass = TextEditingController();
  final conpass = TextEditingController();
  bool isPasswordHidden = true;
  bool isConPasswordHidden = true;
  String gender = 'Female';
  bool? isTermsChecked = false;


  Future<void> pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: .7,
            child: Image.asset('assets/image/one.jpg',
            fit: BoxFit.cover,),
          ),

          SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Welcome back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  HeadingText(
                    headingtext: "Fit Peak",
                    fcolor: Colors.teal,
                  ),
                  const Text(
                    'Lets create an account for you!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomWidget(
                    textEditingController: nameController,
                    labelText: 'Name',
                    prefixIcon: Icons.person,
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name can not be empty';
                      }
        
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomWidget(
                    textEditingController: emailicon,
                    labelText: 'Email',
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
                  SizedBox(height: 10),
                  CustomWidget(
                    textEditingController: pass,
                    labelText: 'Password',
                    prefixIcon: Icons.password,
                    isPasswordHidden: isPasswordHidden,
                    suffixIcon: isPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
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
                    },
                  ),
                  SizedBox(height: 10),
                  CustomWidget(
                    textEditingController: conpass,
                    labelText: 'ConfirmPassword',
                    prefixIcon: Icons.password,
                    isPasswordHidden: isConPasswordHidden,
                    suffixIcon: isConPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixPressed: () {
                      setState(() {
                        isConPasswordHidden = !isConPasswordHidden;
                      });
                    },
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      if(pass.text!=value){
                        return 'you enter wrong password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomWidget(
                      textEditingController: dateController,
                      labelText: 'Date of birth',
                      onTap: pickDate,
                      prefixIcon: Icons.calendar_month),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Gender',
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.green,
                        value: 'Male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      Text('Male'),
                      SizedBox(
                        width: 10,
                      ),
                      Radio(
                        activeColor: Colors.red,
                        value: 'Female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      Text('Female')
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.red,
                        value: isTermsChecked,
                        onChanged: (value) {
                          setState(() {
                            isTermsChecked = value;
                          });
                        },
                      ),
                      Text('I accept terms and conditions.')
                    ],
                  ),
                  ElevatedButton(

                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            // 1. Create user with Firebase Auth
                            UserCredential userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                email: emailicon.text.trim(),
                                password: pass.text.trim());
        
                            // 2. Create user model object
                            UserModel user = UserModel(
                              uid: userCredential.user!.uid,
                              name: nameController.text.trim(),
                              email: emailicon.text.trim(),
                              dob: dateController.text.trim(),
                              gender: gender,
                            );
        
                            // 3. Save user data to Firestore
                            await FirebaseFirestore.instance
                                .collection('user')
                                .doc(user.uid)
                                .set(user.toJson());
        
                            // 4. Navigate after success
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Chosescreen()));
                          } catch (error) {
                            utils().toastmassage(error.toString());
                          }
                        }
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,),
                      child: Text("Signup",style: TextStyle(color:Colors.red),
                      ),
                  ),
                  SizedBox(height: 20,),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("You have acoount?  ",style: TextStyle(),),
                      InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>myAppScreen()));
                        },child: Text('Login',style: TextStyle(color: Colors.tealAccent),),
                      )
        
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    ],
      ),
    );
  }
}
