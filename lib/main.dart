import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smg_senior/OTPCode/SignUpPage.dart';
import 'package:smg_senior/OTPCode/mainOTP.dart';
import 'package:smg_senior/Providers/appoint_prov.dart';
import 'package:smg_senior/Providers/clinic_provider.dart';
import 'package:smg_senior/Util/bottom_bar.dart';
import 'package:smg_senior/screens/DoctorProfile.dart';
import 'package:smg_senior/screens/DoctorRegister.dart';
import 'package:smg_senior/screens/DoctorRegisterNextStep.dart';
import 'package:smg_senior/screens/PatientLogin.dart';
import 'package:smg_senior/screens/appointments.dart';
import 'package:smg_senior/screens/booking.dart';
import 'package:smg_senior/screens/clinicProfile.dart';
import 'package:smg_senior/screens/clinicProfileForUsers.dart';
import 'package:smg_senior/screens/clinic_app.dart';
import 'package:smg_senior/screens/clinic_map.dart';
// import 'package:smg_senior/screens/sorted_clinics.dart';
import 'package:smg_senior/screens/intro_screen.dart';
import 'package:smg_senior/screens/location.dart';
import 'package:smg_senior/screens/recording_screen.dart';
import 'package:smg_senior/screens/response.dart';
import 'package:smg_senior/screens/welcome.dart';

import 'Util/var.dart';
import 'screens/RegisterLogin.dart';
import 'screens/map.dart';
import 'screens/profile.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting();
  //     .then((_) => runApp(const BookingCalendarDemoApp()));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Appoint()),
      ChangeNotifierProvider(create: (_) => ClcID())
    ],
    child: MaterialApp(
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    ),
  ));
}

class MainHome extends StatelessWidget {
  MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong!'),
          );
        } else if (snapshot.hasData) {
          return BottomBar();
        }
        return Login();
        //: ,
        // );
        // Login();
      },
    );
  }
}
