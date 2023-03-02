import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:smg_senior/screens/DoctorLogIn.dart';
import 'package:smg_senior/screens/DoctorProfile.dart';
import 'package:smg_senior/screens/RegisterLogin.dart';

import '../Util/bottom_bar.dart';
import '../myHeader.dart';

class ClinicProfile extends StatefulWidget {
  const ClinicProfile({Key? key}) : super(key: key);

  @override
  State<ClinicProfile> createState() => _ClinicProfileState();
}

class _ClinicProfileState extends State<ClinicProfile> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  int? cid;
  List appClinics = [];
  String clinicName = '';
  String clinicType = '';
  // void fun() async {
  //   clinicName = await getClinic(1);
  // }

  dynamic user = FirebaseAuth.instance.currentUser;
  Future getAppointments() async {
    print(cid);
    var clinics = await FirebaseFirestore.instance
        .collection('Booked')
        .where("clinicId", isEqualTo: cid)
        .get()
        .then((value) {
      appClinics = value.docs;
    });
    // print(appClinics);
    setState(() {});
    // return clinic['Clinic name'];
  }

  @override
  void initState() {
    // getAppointments();
    super.initState();
  }

  // Future getAppointments() async {
  //   print("object");
  //   var clinic;
  //   await FirebaseFirestore.instance
  //       .collection("Booked")
  //       .where("clinicID", isEqualTo: cid)
  //       .get()
  //       .then((value) {
  //     var c = value.docChanges[0].doc.data();
  //     print(c);
  //     // print(c['clinicID']);
  //   });
  //   // return clinic;
  // }

  @override
  Widget build(BuildContext context) {
    dynamic user = FirebaseAuth.instance.currentUser;
    // print(appClinics[1].data());
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
                  .where('docID', isEqualTo: user.uid)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      final data = docs[i].data();
                      // setState(() {
                      //   cid = data['clinicID'];
                      // });
                      // print(cid);
                      return Column(
                        // shrinkWrap: true,
                        crossAxisAlignment: CrossAxisAlignment.stretch,

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
                                      role: user.displayName ?? '',
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
                              title: Text('الرقم التعريفي للعيادة'),
                              subtitle: Text(data['clinicID'].toString()),
                              leading: Icon(
                                Icons.credit_card,
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
                              title: Text('الرقم التعريفي للسكرتير'),
                              subtitle: Text(data['secretaryID'].toString()),
                              leading: Icon(
                                Icons.credit_card,
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
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   scrollDirection: Axis.horizontal,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     return Text(appClinics[i].data() ?? "");
                          //   },
                          // ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DoctorProfile()));
                              },
                              child: Text('العودة الى صفحة الطبيب'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff2894B1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: ElevatedButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut().then((res) {
                                  (Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login())));
                                });
                              },
                              child: Text('تسجيل خروج'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff2894B1)),
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
