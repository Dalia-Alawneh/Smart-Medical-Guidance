import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smg_senior/OTPCode/mainOTP.dart';
import 'package:smg_senior/Util/var.dart';
import 'package:smg_senior/screens/PatientLogin.dart';

import '../Util/RegistrerInfo.dart';

class PatientRegister extends StatefulWidget {
  const PatientRegister({Key? key}) : super(key: key);

  @override
  State<PatientRegister> createState() => _PatientRegisterState();
}

class _PatientRegisterState extends State<PatientRegister> {
  bool _isObscure = true;
  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bDateController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    bDateController.dispose();
    cityController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfController.dispose();
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
                      controller: nameController,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.person),
                          hintStyle: TextStyle(
                            color: Color(0xff21A7CC),
                            fontFamily: 'Tajawal',
                            fontSize: 18,
                          ),
                          hintText: 'الاسم الكامل',
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى ادخال الاسم';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.phone_android_outlined),
                          hintStyle: TextStyle(
                            color: Color(0xff21A7CC),
                            fontFamily: 'Tajawal',
                            fontSize: 18,
                          ),
                          hintText: 'رقم الهاتف',
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى ادخال الرقم';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: bDateController,
                      keyboardType: TextInputType.datetime,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.calendar_month_outlined),
                          hintStyle: TextStyle(
                            color: Color(0xff21A7CC),
                            fontFamily: 'Tajawal',
                            fontSize: 18,
                          ),
                          hintText: 'تاريخ الميلاد',
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى ادخال تاريخ الميلاد';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: cityController,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.location_pin),
                          hintStyle: TextStyle(
                            color: Color(0xff21A7CC),
                            fontFamily: 'Tajawal',
                            fontSize: 18,
                          ),
                          hintText: 'المدينة',
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى ادخال المدينة';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.mail),
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
                      height: 10,
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
                            child: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          hintText: 'كلمة المرور',
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى ادخال كلمة المرور';
                        } else if (value.length < 8)
                          return 'كلمة المرور يجب ان تكون 8 خانات على الأقل';

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordConfController,
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
                            child: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          hintText: 'تأكيد كلمة المرور',
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى تأكيد كلمة المرور';
                        } else if (value != passwordController.text)
                          return 'لا يوجد تطابق';

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
                                signUp();
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
                              "انشاء حساب",
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
                          "لديك حساب بالفعل ؟ ",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PatientLogIn();
                            }));
                          },
                          child: Text(
                            "تسجيل دخول",
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

  Future signUp() async {
    try {
      print(emailController.text.trim());
      print(passwordController.text.trim());
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
                child: CircularProgressIndicator(),
              ));
      final newPatient = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      // await newPatient.user!.updateDisplayName(displayName);
      User? user = newPatient.user;
      if (user != null) {
        user.updateDisplayName(displayName);
        //get updated user
        await user.reload();
        //print final version to console
        print("Registered user:");
        print(user);
        //add patient
        try {
          Map<String, dynamic> patient = {
            "name": nameController.text.trim(),
            "phone": phoneController.text.trim(),
            "bDate": bDateController.text.trim(),
            "city": cityController.text.trim(),
            "uid": user.uid
          };
          await FirebaseFirestore.instance.collection('Patients').add(patient);
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Text('$e'),
                  ));
        }
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PatientLogIn()));
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text('$e'),
              ));
    }
  }
}
