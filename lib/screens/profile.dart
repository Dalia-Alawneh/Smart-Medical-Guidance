import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:smg_senior/Util/divline.dart';
import 'package:smg_senior/body.dart';
import 'package:smg_senior/screens/PatientLogin.dart';
import 'package:smg_senior/screens/RegisterLogin.dart';
import 'package:smg_senior/screens/appointments.dart';

import '../Util/bottom_bar.dart';
import '../myHeader.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedInUser;

  // late String currentUser, name, em, phon, cit;
  // late DateTime birth;
  //
  // void getUserData(var user) async {
  //
  //   final fullName = user.data['name'];
  //   final email = user.data['email'];
  //   final birthdate = user.data['bDate'];
  //   final phone = user.data['phone'];
  //   final city = user.data['city'];
  //   final userID=user.data['uid'];
  //   currentUser = loggedInUser.uid;
  //   if (userID == currentUser) {
  //     setState(() {
  //       name = '$fullName';
  //       print(name);
  //       em = '$email';
  //       birth = '$birthdate' as DateTime;
  //
  //       cit = '$city';
  //     });
  //   }
  // }
  // void patientsStream()async{
  //
  //   await for(var snapshot in _firestore.collection('Patients').snapshots()){
  //     for( var user in snapshot.docs){
  //       getUserData(user);
  //     }
  //   }
  // }
  //
  // @override
  // void initState() {
  //   getCurrentUser();
  //   patientsStream();
  //   super.initState();
  // }
  //
  // void getCurrentUser() async {
  //   try {
  //     final user = await _auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    dynamic user = FirebaseAuth.instance.currentUser;
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          //       bottomNavigationBar: BottomBar(),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    backgroundColor: Color(0xff2894B1),
                    expandedHeight: 300.0,
                    floating: false,
                    pinned: true,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        collapseMode: CollapseMode.pin,
                        title: Text("الصفحة الشخصية",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontFamily: 'Lalezar',
                            )),
                        background: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: MyHeader(
                              image: "images/patient.jpeg",
                            )))),
              ];
            },

            body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Patients')
                  .where('uid', isEqualTo: user.uid)
                  .snapshots(),
              builder: (_, snapshot) {
                print('hh');
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  print('hhhhhhhhhh');
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      final data = docs[i].data();

                      print(data);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        // shrinkWrap: true,
                        children: [
                          //   MyHeader(image: "images/Home.jpeg",),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            color: Color(0xfff8f9fa),
                            shadowColor: Color(0xff86bdf3),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: ProfilePicture(
                                      name: data['name'],
                                      role: user.displayName ?? '',
                                      tooltip: true,
                                      radius: 30,
                                      fontsize: 20,
                                    ),
                                  ),
                                  Text(
                                    data['name'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Tajawal',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding:
                                EdgeInsets.only(right: 25, top: 30, bottom: 10),
                            child: Text(
                              'المعلومات الشخصية',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xff2894B1),
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),

                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            shadowColor: Color(0xff86bdf3),
                            color: Color(0xfff8f9fa),
                            child: ListTile(
                              title: Text(
                                'الاسم الكامل',
                              ),
                              subtitle: Text(data['name']),
                              leading: Icon(
                                Icons.person_outlined,
                                color: Color(0xff2894B1),
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            shadowColor: Color(0xff86bdf3),
                            color: Color(0xfff8f9fa),
                            child: ListTile(
                              title: Text('تاريخ الميلاد'),
                              subtitle: Text(data['bDate']),
                              leading: Icon(
                                Icons.date_range_outlined,
                                color: Color(0xff2894B1),
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            shadowColor: Color(0xff86bdf3),
                            color: Color(0xfff8f9fa),
                            child: ListTile(
                              title: Text('رقم الهاتف'),
                              subtitle: Text(data['phone']),
                              leading: Icon(
                                Icons.phone,
                                color: Color(0xff2894B1),
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            shadowColor: Color(0xff86bdf3),
                            color: Color(0xfff8f9fa),
                            child: ListTile(
                              title: Text('المدينة'),
                              subtitle: Text(data['city']),
                              leading: Icon(
                                Icons.location_on,
                                color: Color(0xff2894B1),
                              ),
                            ),
                          ),

                          Padding(
                            padding:
                                EdgeInsets.only(right: 25, top: 30, bottom: 10),
                            child: Text(
                              'الحجوزات',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xff2894B1),
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),

                          Column(
                            // scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyAppointments()));
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 3),
                                  shadowColor: Color(0xff2894B1),
                                  color: Color(0xfff8f9fa),
                                  child: ListTile(
                                    title: Text('انقر لعرض حجوزاتك'),
                                    //    subtitle: Text('2'),
                                    leading: Icon(
                                      Icons.format_list_numbered_rtl,
                                      color: Color(0xff2894B1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //     Text(data['bDate']),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut().then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                });
                              },
                              child: Text('تسجيل خروج'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff2894B1)),
                            ),
                          ),
                        ],
                      );

                      //   Column(
                      //   children:[
                      //     ListView(
                      //       children: [
                      //         Text(data['bDate']),
                      //         Text(data['city']),
                      //         ElevatedButton(
                      //             onPressed: () {
                      //               FirebaseAuth.instance.signOut();
                      //             },
                      //             child: Text('sign out'))
                      //       ],
                      //     ),
                      //   ]
                      // );

                      ListTile(
                        title: Text(data['bDate']),
                        subtitle: Text(data['city']),
                      );

                      // } else {
                      //   return Text('');
                      // }
                    },
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
            // Center(
            //   child:
            //   Column(children: [
            //     Text(''+user.email),
            //     Text(user.displayName??''),
            //     ElevatedButton(
            //         onPressed: () {
            //           FirebaseAuth.instance.signOut();
            //         },
            //         child: Text('sign out'))
            //   ]),
            // ),
          )),
    ));
  }
}
