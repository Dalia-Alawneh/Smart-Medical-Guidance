import 'dart:html';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordState();
  }
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var w = Color.fromARGB(255, 255, 255, 255);
  var g2 = Color.fromARGB(255, 73, 73, 73);
  var b1 = Color.fromARGB(255, 8, 136, 175);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          persistentFooterAlignment: AlignmentDirectional.center,
          body: ListView(
            padding: EdgeInsets.symmetric(vertical: 100),
            children: [
              Image.asset(
                "images/SMG.png",
                width: 110,
                height: 110,
              ),
              Container(
                child: Center(
                  child: Text(
                    "مشكلة في تسجيل الدخول؟",
                    style: TextStyle(color: b1, fontSize: 25),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    " أدخل رقم هاتفك، وسنرسل لك رمز تسجيل الدخول لإسترداد حسابك",
                    style: TextStyle(color: b1),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: w),
                    decoration: InputDecoration(

                        prefixText: "+970  ",
                        fillColor: g2,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        // labelText: "رقم الهاتف",
                        // labelStyle: TextStyle(
                        //   fontSize: 15,
                        //   color: w,
                        // ),
                        hintText: "ادخل رقم الهاتف",
                        hintStyle: TextStyle(fontSize: 10, color: w),

                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.white,
                        )),
                    keyboardType: TextInputType.number,
                  )),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                ),

                child: const Text('متابعة'),
              ),

            ],
          ),
        ));
  }
}
