import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smg_senior/screens/PatientLogin.dart';
import 'package:smg_senior/screens/recording_screen.dart';

class moreInfo extends StatefulWidget {
  @override
  _moreInfoState createState() => _moreInfoState();
}

class _moreInfoState extends State<moreInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          return
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    Image(image: AssetImage('images/needmoresymptoms.png'), width: 150,
                    height: 150,),
                    SizedBox(
                      height: 10,
                    ),
                    Text('يرجى إعطاء المزيد من المعلومات حول حالتك',
                      style: TextStyle(
                        fontFamily: 'Lalezar',
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 120, vertical:0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyApp()));
                        },
                        child: Text('تكلّم مرة أخرى'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff2894B1)),
                      ),
                    ),
                  ],
                ),
              ],
            );
          // : CircularProgressIndicator();
        },
      ),
    );
  }}