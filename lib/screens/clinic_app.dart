import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:provider/provider.dart';
import 'package:smg_senior/Providers/appoint_prov.dart';
import 'package:smg_senior/screens/DoctorLogIn.dart';
import 'package:smg_senior/screens/DoctorProfile.dart';

import '../Util/bottom_bar.dart';
import '../Util/colors.dart';
import '../myHeader.dart';

class ClinicAppointments extends StatelessWidget {
  // const MyAppointments({Key? key}) : super(key: key);
  ClinicAppointments({required this.cid});
  late User loggedInUser;
  int cid;
  dynamic user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    print(cid);
    return SafeArea(
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              //      bottomNavigationBar: ButtonBar(),
              backgroundColor: Colors.white,
              body: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 40),
                  child: Text(
                    'حجوزات اليوم',
                    style: TextStyle(
                      fontFamily: 'Lalezar',
                      fontSize: 40,
                      color: Color(0xff2894B1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      KColor.secBlueColor,
                      KColor.lighterBlueColor,
                      // KColor.secBlueColor,
                    ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('Booked')
                        .where('clinicId', isEqualTo: cid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error = ${snapshot.error}');
                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        print(docs);
                        return docs.length > 0
                            ? ListView.builder(
                                itemCount: docs.length,
                                itemBuilder: (_, i) {
                                  final data = docs[i].data();
                                  print((data["clinicId"]));
                                  context
                                      .read<Appoint>()
                                      .getName(data["clinicId"]);
                                  var startDate = data["start"].split('T')[0];
                                  var startTime = data["start"]
                                      .split('T')[1]
                                      .toString()
                                      .substring(0, 5);
                                  var endDate = data["end"].split('T')[0];
                                  var endTime = data["end"]
                                      .split('T')[1]
                                      .toString()
                                      .substring(0, 5);
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          top: 52, left: 30, right: 30),
                                      child: BlurryContainer(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        color: Colors.white.withOpacity(0.15),
                                        blur: 8,
                                        padding: const EdgeInsets.all(32),
                                        // margin: EdgeInsets.only(top:50),
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              // shrinkWrap: true,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '$startDate',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff034456),
                                                          fontFamily:
                                                              'Lalezar'),
                                                    ),
                                                    Text(
                                                      '${i + 1}   الموعد رقم',
                                                      // '${data['clinicId']}' ,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff034456),
                                                          fontFamily:
                                                              'Lalezar'),
                                                    )
                                                    // Text('$endDate'),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '$startTime - $endTime',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white70,
                                                          fontFamily:
                                                              'Lalezar'),
                                                    ),

                                                    // Text(
                                                    //   context
                                                    //       .read<
                                                    //           Appoint>()
                                                    //       .clinic_type,
                                                    //   style: TextStyle(
                                                    //       fontSize: 15,
                                                    //       color: Colors
                                                    //           .white70,
                                                    //       fontFamily:
                                                    //           'Lalezar'),
                                                    // )
                                                  ],
                                                )
                                                //       Text('${data["end"]}')
                                              ]),
                                        ),
                                      ));
                                },
                              )
                            :  Center(
                                        child: Text(
                                          "ليس لديك حجوزات بعد",
                                          style: TextStyle(
                                            fontFamily: 'Lalezar',
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ))
              ]))),
    );
  }
}
