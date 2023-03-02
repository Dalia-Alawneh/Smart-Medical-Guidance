import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String phoneNumber, verificationId;
  late String otp, authStatus = "";
  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          authStatus = "تم التحقق من حسابك بنجاح";
        });
      },
      verificationFailed: (exception) {
        setState(() {
          authStatus = "فشلت المصادقة";
        });
      },
      codeSent: (String verId, [int? forceCodeResent]) {
        verificationId = verId;
        setState(() {
          authStatus = "تم ارسال الرمز بنجاح";
        });
        otpDialogBox(context).then((value) {});
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
      },
    );
  }

  otpDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('أدخل الرمز الذي تم ارساله إليك'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),
                ),
                onChanged: (value) {
                  otp = value;
                },
              ),
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  signIn(otp);
                },
                child: Text(
                  'تأكيد',
                ),
              ),
            ],
          );
        });
  }

  Future<void> signIn(String otp) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Image.asset(
                'images/logo.jpeg',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(30),
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.phone_iphone,
                        color: Color(0xff2894B1),
                      ),
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      hintText: "أدخل رقم هاتفك",
                      fillColor: Colors.white70),
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                style:ElevatedButton.styleFrom(
                    primary: Color(0xff2894B1),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),

            //    ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20),),
                // RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30)),
                onPressed: () =>
                phoneNumber == null ? null : verifyPhoneNumber(context),
                child: Text(
                  "أرسل الرمز",
                  style: TextStyle(color: Colors.white),
                ),
                //    elevation: 7.0,
                //  color: Colors.cyan,
              ),
              SizedBox(
                height: 30,
              ),
              // Text("Need Help?"),
              // SizedBox(
              //   height: 20,
              // ),
              Text(
                "رجاءاً أدخل رقم الهاتف مع المقدمة (+972)",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                authStatus == "" ? "" : authStatus,
                style: TextStyle(
                    color: authStatus.contains("حدث خطأ، حاول من جديد") ||
                        authStatus.contains("نفذ الوقت")
                        ? Colors.red
                        : Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }
}