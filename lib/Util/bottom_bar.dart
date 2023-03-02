import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smg_senior/Providers/clinic_provider.dart';
import 'package:smg_senior/Util/colors.dart';
import 'package:smg_senior/screens/RegisterLogin.dart';
// import 'package:smg_senior/screens/app.dart';
import 'package:smg_senior/screens/appointments.dart';
import 'package:smg_senior/screens/booking.dart';
import 'package:smg_senior/screens/clinicProfileForUsers.dart';
import 'package:smg_senior/screens/clinic_app.dart';
import 'package:smg_senior/screens/guest_profile.dart';
import 'package:smg_senior/screens/profile.dart';
import 'package:smg_senior/screens/recording_screen.dart';
import 'package:smg_senior/screens/welcome.dart';
import '../Providers/appoint_prov.dart';
import '../screens/DoctorProfile.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _activePage = 0;
  //int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int clcID = 0;
  @override
  void initState() {
    // context.read<ClcID>().getId();
    // clcid = context.read<ClcID>().clcID;
    // print(clcid);
    getId();
    // TODO: implement initState
    super.initState();
  }

  Future getId() async {
    var clinic;
    await FirebaseFirestore.instance
        .collection('Clinics')
        .where("docID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((data) {
      // clinic = data.docChanges.first.doc.data();
      data.docs.forEach((element) {
        clcID = element['clinicID'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(clcID);
    var user = FirebaseAuth.instance.currentUser;
    dynamic icons = [
      Icon(Icons.mic_none_outlined, size: 30),
      Icon(Icons.list, size: 30),
      Icon(Icons.perm_identity, size: 30),
    ];
    dynamic iconsForGuest = [
      Icon(Icons.mic_none, size: 30),
      Icon(Icons.perm_identity, size: 30),
    ];
    final List<Widget> _tabItems = [
      MyApp(),
      user?.displayName == "doctor"
          ? ClinicAppointments(
              cid: clcID,
            )
          : MyAppointments(),
      user?.displayName == "doctor"
          ? DoctorProfile()
          : user?.displayName == "patient"
              ? Profile()
              : homeOTP(),
    ];
    final List<Widget> _tabItemsForGuest = [
      MyApp(),
      user?.displayName == "doctor"
          ? DoctorProfile()
          : user?.displayName == "patient"
              ? Profile()
              : homeOTP(),
    ];
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: user!.displayName == null || user.displayName == ''
              ? iconsForGuest
              : icons,
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: KColor.secBlueColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              print(user);
              _activePage = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: user.displayName == null || user.displayName == ''
            ? _tabItemsForGuest[_activePage]
            : _tabItems[_activePage]);
  }
}
