import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smg_senior/Util/RegistrerInfo.dart';
import 'package:smg_senior/Util/bottom_bar.dart';
import 'package:smg_senior/Util/var.dart';
import 'package:smg_senior/screens/DoctorRegister.dart';
import 'package:smg_senior/screens/RegisterForPatient.dart';
import 'package:smg_senior/screens/profile.dart';
import 'package:smg_senior/screens/recording_screen.dart';

class PatientLogIn extends StatefulWidget {
  const PatientLogIn({Key? key}) : super(key: key);

  @override
  State<PatientLogIn> createState() => _PatientLogInState();
}

class _PatientLogInState extends State<PatientLogIn> {
  bool _isObscure = true;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.only(top: 40, bottom: 5),
            child: Image.asset(
              'images/logo.jpeg',
              width: 130,
              height: 130,
            ),
          ),
          Text(
            'التوجيه الطبي الذكي',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff21A7CC),
              fontSize: 30,
              fontFamily: 'Tajawal',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.person_outline),
                          hintStyle: TextStyle(
                            color: Color(0xff21A7CC),
                            fontFamily: 'Tajawal',
                            fontSize: 18,
                          ),
                          hintText: 'البريد الالكتروني',
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى ادخال البريد الالكتروني';
                        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'يرجى ادخال بريدالكتروني صحيح';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.key),
                          hintStyle: TextStyle(
                            color: Color(0xff21A7CC),
                            fontFamily: 'Tajawal',
                            fontSize: 18,
                          ),
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },

                            child: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            // onPressed: () {
                            // },
                          ),
                          hintText: 'كلمة المرور',
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى ادخال كلمة المرور';
                        }
                        return null;
                      },
                    ),
                    GestureDetector(
                      onTap: null,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xff21A7CC),
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: ListTile(
                          title: GestureDetector(
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                signIn();
                              } else {
                                // showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return Dialog(
                                //         child: Column(children: [
                                //           Text('')
                                //         ]),
                                //       );
                                //     });
                              }
                            },
                            child: Text(
                              "تسجيل الدخول",
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: null,
                      child: Text(
                        'هل نسيت كلمة المرور؟',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لديك حساب ؟',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return displayName=="patient"? PatientRegister():DoctorRegister();
                            }));
                          },
                          child: Text(
                            "انشاء حساب",
                            style: TextStyle(
                              color: Color(0xff21A7CC),
                              fontSize: 17,
                              fontFamily: 'Lateef',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          )
        ]),
      ),
    );
  }

  Future signIn() async {
    try {
      print(emailController.text.trim());
      print(passwordController.text.trim());
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
                child: CircularProgressIndicator(),
              ));
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomBar()));
    } catch (e) {
      print(e);
      Navigator.pop(context);
    }
  }
}
