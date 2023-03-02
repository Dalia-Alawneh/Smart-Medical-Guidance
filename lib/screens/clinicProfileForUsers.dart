import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:smg_senior/screens/DoctorLogIn.dart';
import 'package:smg_senior/screens/DoctorProfile.dart';
import 'package:smg_senior/screens/appoint_for_guest.dart';
import 'package:smg_senior/screens/booking.dart';

import '../Util/bottom_bar.dart';
import '../myHeader.dart';

class ClinicProfileForUsers extends StatefulWidget {
  const ClinicProfileForUsers({this.cid});

  final cid;
  @override
  State<ClinicProfileForUsers> createState() => _ClinicProfileForUsersState();
}

class _ClinicProfileForUsersState extends State<ClinicProfileForUsers> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedInUser;

  @override
  Widget build(BuildContext context) {
    dynamic user = FirebaseAuth.instance.currentUser;
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          // bottomNavigationBar: BottomBar(),
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
                        title: Text("الصفحة الشخصية للعيادة",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontFamily: 'Lalezar',
                            )),
                        background: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: MyHeader(
                              image: "images/Home.jpeg",
                            )))),
              ];
            },
            body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Clinics')
                  .where('clinicID', isEqualTo: widget.cid)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      final data = docs[i].data();
                      print(data);
                      return ListView(
                        shrinkWrap: true,
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
                                      name: data['Clinic name'],
                                      // role: user.displayName??'',
                                      tooltip: true,
                                      radius: 30,
                                      fontsize: 20,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['Clinic name'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Tajawal',
                                        ),
                                      ),
                                      Text(
                                        data['Clinic type'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Tajawal',
                                        ),
                                        //textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding:
                                EdgeInsets.only(right: 25, top: 30, bottom: 10),
                            child: Text(
                              'المعلومات الخاصة بالعيادة',
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
                                'اسم العيادة',
                              ),
                              subtitle: Text(data['Clinic name']),
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
                              title: Text('موقع العيادة'),
                              subtitle: Text(data['Description']),
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
                              subtitle: Text(data['Phone Number'].toString()),
                              leading: Icon(
                                Icons.phone,
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
                          GestureDetector(
                            onTap: () {
                              if (user.displayName == 'patient') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookingCalendarDemoApp(
                                      cid: widget.cid,
                                    ),
                                  ),
                                );
                              } else
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => guestNav()));
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 3),
                              shadowColor: Color(0xff86bdf3),
                              color: Color(0xfff8f9fa),
                              child: ListTile(
                                title: Text('اضغط للذهاب لصفحة الحجوزات'),
                                subtitle: Text('احجز موعدك الآن'),
                                leading: Icon(
                                  Icons.book_online,
                                  color: Color(0xff2894B1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          )),
    ));
  }
}
