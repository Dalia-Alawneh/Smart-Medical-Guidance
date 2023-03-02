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

class MyAppointments extends StatefulWidget {
  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  // const MyAppointments({Key? key}) : super(key: key);
  late User loggedInUser;

  // String clinicType = 'عيادة خاصة';
  dynamic user = FirebaseAuth.instance.currentUser;

  Map names = {
    0: "عيادة د. وليد شاكر حسين مسعود",
    1: "عيادة د. مصطفى ناصر حمارشة ",
    10: "عيادة د. احمد ابو دقر ",
    11: "عيادة د. نظام سعيد نجم ",
    12: 'عيادة د. جرير البري ',
    13: "عيادة د. عرفات حسين زكارنة ",
    14: "عيادة د. عمر عبد الغني البرق ",
    15: 'عيادة د. طارق محمد خلف ',
    16: 'عيادة د. زياد نزال ',
    17: 'عيادة د. تاتيانا الجيوسي و د.سعيد الجيوسي',
    18: 'عيادة الدكتور نهاد أحمد الغول',
    19: 'عيادة الدكتور محمد جرادات',
    2: 'عيادة د. نصر عطا جعفر ',
    3: 'عيادة د. يزيد عبد الحليم الجيوسي ',
    4: 'عيادة د. محمد احمد جابر ',
    5: 'عيادة د. سمير عتيق ',
    6: 'عيادة د. هشام عادل استيتية ',
    7: 'عيادة د. مروان الخطيب ',
    8: 'عيادة د. ناهض عبيدي ',
    9: 'عيادة د. وسام صبيحات '
  };

  Future getClinic(var id) async {
    var clinic;
    await FirebaseFirestore.instance
        .collection('Clinics')
        .where("clinicID", isEqualTo: id)
        .get()
        .then((data) {
      // use ds as a snapshot
      clinic = data.docs[0].data();
      // print(clinic['Clinic name']);
      // print(clinicName);
    });
    // print(clinic["Clinic name"]);
    // print(clinicName);
    // setState(() {});
    // print(clinics);
    // setState(() {
    // clinicName = clinic["Clinic name"];
    // clinicType = clinic['Clinic type'];
    // });
    // return clinics;
  }

  showMyDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 5,
          backgroundColor: KColor.lighterrrrBlueColor,
          child: IntrinsicHeight(
            child: Container(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                decoration: BoxDecoration(
                    color: KColor.lighterrrrBlueColor,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 215, 215, 215),
                          blurRadius: 8)
                    ]),
                child: Column(
                  children: [
                    Text(
                      "تأكيد الحذف",
                      style: TextStyle(
                          color: KColor.secBlueColor,
                          fontFamily: 'Lalezar',
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () async {
                              Navigator.pop(context, true);
                            },
                            child: Text(
                              "تأكيد",
                              style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: KColor.secBlueColor),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text(
                              "الغاء",
                              style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                //      bottomNavigationBar: ButtonBar(),
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 40),
                      child: Text(
                        'حجوزاتي',
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
                        child: StreamBuilder<
                                QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('Booked')
                                .where('patientID', isEqualTo: user.uid)
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError)
                                return Text('Error = ${snapshot.error}');
                              if (snapshot.hasData) {
                                final docs = snapshot.data!.docs;
                                return docs.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: docs.length,
                                        itemBuilder: (_, i) {
                                          final data = docs[i].data();
                                          print((docs[i].id));
                                          context
                                              .read<Appoint>()
                                              .getName(data["clinicId"]);
                                          // var e = context
                                          //     .read<Appoint>()
                                          //     .clinics
                                          //     .firstWhere((element) => element);
                                          // print(e);
                                          // int myI = context
                                          //     .read<Appoint>()
                                          //     .clinics
                                          //     .indexOf();

                                          // var clinic =
                                          // getClinic(data["clinicId"]);
                                          //  print(clinic.toString());
                                          // print(data);
                                          var startDate =
                                              data["start"].split('T')[0];
                                          var startTime = data["start"]
                                              .split('T')[1]
                                              .toString()
                                              .substring(0, 5);
                                          var endDate =
                                              data["end"].split('T')[0];
                                          var endTime = data["end"]
                                              .split('T')[1]
                                              .toString()
                                              .substring(0, 5);
                                          return Dismissible(
                                            background: Container(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              margin: EdgeInsets.only(
                                                  top: 50, right: 15, left: 15),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "حذف الحجز",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontFamily: 'Tajawal'),
                                                  )),
                                              color: Colors.red,
                                            ),
                                            key: UniqueKey(),
                                            confirmDismiss:
                                                (dismissDirection) async {
                                              switch (dismissDirection) {
                                                case DismissDirection
                                                    .endToStart:
                                                case DismissDirection
                                                    .startToEnd:
                                                  return await showMyDialog() ==
                                                      true;

                                                case DismissDirection.none:
                                                  // TODO: Handle this case.
                                                  break;
                                              }
                                              return false;
                                            },
                                            onDismissed: (direction) async {
                                              print(docs[i].id);
                                              await FirebaseFirestore
                                                  .instance
                                                  .collection('Booked')
                                                  .doc('${docs[i].id}').delete();
                                            },
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 52,
                                                    left: 30,
                                                    right: 30),
                                                child: BlurryContainer(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
                                                  color: Colors.white
                                                      .withOpacity(0.15),
                                                  blur: 8,
                                                  padding:
                                                      const EdgeInsets.all(32),
                                                  // margin: EdgeInsets.only(top:50),
                                                  child: Directionality(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
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
                                                                    fontSize:
                                                                        15,
                                                                    color: Color(
                                                                        0xff034456),
                                                                    fontFamily:
                                                                        'Lalezar'),
                                                              ),
                                                              Text(
                                                                names[data[
                                                                    'clinicId']],
                                                                // '${data['clinicId']}' ,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Color(
                                                                        0xff034456),
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
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white70,
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
                                                )),
                                          );
                                        },
                                      )
                                    : Center(
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
                            }),
                      ),
                    ),
                  ],
                ))));
  }
}
