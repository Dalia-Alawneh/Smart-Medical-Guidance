import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class homeOTP extends StatefulWidget {
  @override
  _homeOTPState createState() => _homeOTPState();
}

class _homeOTPState extends State<homeOTP> {
  // Future<void> _logout() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
       future: Future<User>.value(FirebaseAuth.instance.currentUser),
        builder: (context, snapshot) {
         User? firebaseUser = snapshot.data as User?;
          return
            snapshot.hasData
              ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffB4D6F2),
                        backgroundImage:AssetImage('images/guest.png') ,
                        radius: 50,),
                      SizedBox(
                        height: 10,
                      ),
                          Text('حساب زائر',
                            style: TextStyle(
                              fontFamily: 'Lalezar',
                              fontSize:18,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,),
        //        Text("UserId: ${firebaseUser!.uid}"),
                      SizedBox(
                        height: 5,
                      ),
                      Text('رقم الهاتف المسجل: ${firebaseUser!.phoneNumber}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lalezar',
                          fontSize:15,
                          color: Colors.black87,
                        ),
                      ),
                      // Text(
                      //     "Registered Phone Number: ${firebaseUser.phoneNumber}"),
                      SizedBox(
                        height: 40,
                      ),

                        Padding(
                        padding: EdgeInsets.symmetric(horizontal: 120, vertical:0),
                          child: ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: Text('تسجيل خروج'),
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2894B1)),
                          ),
                        ),
                    ],
                  ),
                ],
              )
               : CircularProgressIndicator();
        },
      ),
    );
  }
}