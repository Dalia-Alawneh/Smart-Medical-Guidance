import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smg_senior/OTPCode/SignUpPage.dart';
import 'package:smg_senior/screens/DoctorLogIn.dart';
import '../Util/RegistrerInfo.dart';
import '../Util/var.dart';
import 'DoctorRegisterNextStep.dart';
import 'PatientLogin.dart';
import 'RegisterForPatient.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({Key? key}) : super(key: key);

  @override
  State<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  bool _isObscure = true;
  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final idController = TextEditingController();
  final bDateController = TextEditingController();
  final detailController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    idController.dispose();
    bDateController.dispose();
    detailController.dispose();
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
          const Text(
            'التوجيه الطبي الذكي',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff21A7CC),
              fontSize: 30,
              fontFamily: 'Tajawal',
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20.0, top: 10),
            child: Text(
              'إنشاء حساب للطبيب',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Color(0xff21A7CC),
                fontSize: 25,
                fontFamily: 'Tajawal',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                      controller: idController,
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
                          hintText: 'رقم الهوية',
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى ادخال رقم الهوية';
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
                      controller: detailController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.text_snippet_outlined),
                          hintStyle: TextStyle(
                            color: Color(0xff21A7CC),
                            fontFamily: 'Tajawal',
                            fontSize: 18,
                          ),
                          hintText: 'نبذة تعريفية',
                          fillColor: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                        } else if (value.length < 8) {
                          return 'كلمة المرور يجب ان تكون 8 خانات على الأقل';
                        }

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
                              'إنشاء حساب',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' لديك حساب؟ ',
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
                            'تسجيل الدخول',
                            style: TextStyle(
                              color: Color(0xff21A7CC),
                              fontSize: 17,
                              fontFamily: 'Tajawal',
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
      displayName = "doctor";
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
          Map<String, dynamic> doctor = {
            "name": nameController.text.trim(),
            "phone": phoneController.text.trim(),
            "id": idController.text.trim(),
            "bDate": bDateController.text.trim(),
            "details": detailController.text.trim(),
            "uid": user.uid
          };
          await FirebaseFirestore.instance.collection('Doctors').add(doctor);
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
