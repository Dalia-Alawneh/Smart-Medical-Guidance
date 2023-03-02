import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smg_senior/Util/bottom_bar.dart';
import 'package:smg_senior/screens/recording_screen.dart';
import 'SignUpPage.dart';
import 'homePage.dart';

class MainOTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          // stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return BottomBar();
            } else if (userSnapshot.hasError) {
              return CircularProgressIndicator();
            }
            return LoginPage();
          },
        ));
  }
}
