import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:smg_senior/screens/RegisterLogin.dart';
import 'package:smg_senior/screens/clinicProfile.dart';
import '../myHeader.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
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
                        title: Text("الصفحة الشخصية للطبيب",
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
                  .collection('Doctors')
                  .where('uid', isEqualTo: user.uid)
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        // shrinkWrap: true,
                        children: [
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['name'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Tajawal',
                                        ),
                                      ),
                                      Text(
                                        data['details'],
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
                              title: Text('رقم الهوية'),
                              subtitle: Text(data['id']),
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
                          Padding(
                            padding:
                                EdgeInsets.only(right: 25, top: 30, bottom: 10),
                            child: Text(
                              'العيادات',
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
                              Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                shadowColor: Color(0xff2894B1),
                                color: Color(0xfff8f9fa),
                                child: ListTile(
                                  title: Text('عدد العيادات المجسلة'),
                                  subtitle: Text('1'),
                                  leading: Icon(
                                    Icons.format_list_numbered_rtl,
                                    color: Color(0xff2894B1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClinicProfile()));
                              },
                              child: Text('الذهاب الى صفحة العيادة'),
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
