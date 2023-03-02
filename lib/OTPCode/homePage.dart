import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class homeOTP extends StatefulWidget {
  @override
  _homeOTPState createState() => _homeOTPState();
}

class _homeOTPState extends State<homeOTP> {
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth Demo"),
        backgroundColor: Colors.cyan,
      ),
      body: FutureBuilder(
        future: Future<User>.value(FirebaseAuth.instance.currentUser),
        builder: (context, snapshot) {
          User? firebaseUser = snapshot.data as User?;
          return snapshot.hasData
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "SignIn Success 😊",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("UserId: ${firebaseUser!.uid}"),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "Registered Phone Number: ${firebaseUser.phoneNumber}"),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _logout,
                  child: Text(
                    "LogOut",
                    style: TextStyle(color: Colors.white),
                  ),
                  // color: Colors.cyan,
                )
              ],
            ),
          )
              : CircularProgressIndicator();
        },
      ),
    );
  }
}