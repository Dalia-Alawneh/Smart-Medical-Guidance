// import 'package:flutter/material.dart';
// import 'package:smg_senior/screens/PatientLogin.dart';
//
// import 'info_card.dart';
//
//
// class Information extends StatelessWidget {
//
//   final Name;
//   final birthdate;
//   final phone;
//   final pName;
//   final pPhone;
//   final doctor;
//   int age;
//   Information({this.Name,this.birthdate,this.phone,this.pName,this.pPhone,this.doctor, required this.age});
//
//
//
//   calculateAge(DateTime birthDate) {
//     DateTime currentDate = DateTime.now();
//     int age = currentDate.year - birthDate.year;
//     int month1 = currentDate.month;
//     int month2 = birthDate.month;
//     if (month2 > month1) {
//       age--;
//     } else if (month1 == month2) {
//       int day1 = currentDate.day;
//       int day2 = birthDate.day;
//       if (day2 > day1) {
//         age--;
//       }
//     }
//     return age;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime birth= DateTime.parse(birthdate);
//     age=calculateAge(birth);
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           color: Colors.white,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Center(
//                   child: Container(
//                     margin: EdgeInsets.all(20),
//                     width: 200,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                           image: AssetImage('assets/images/elderly.png'),
//                           fit: BoxFit.fill),
//                     ),
//                   ),
//                 ),
//                 InformationCard(
//                   title: 'Name',
//                   subTitle: '${Name}',
//                 ),
//                 InformationCard(
//                   title: 'Birthdate',
//                   subTitle: '${birthdate}',
//                 ),
//                 InformationCard(title: 'Age', subTitle: '${age}',),
//                 InformationCard(
//                   title: 'Phone Number',
//                   subTitle:'${phone}',
//                 ),
//                 InformationCard(
//                   title: 'Name of person who takes care about you',
//                   subTitle: '${pName}',
//                 ),
//
//                 InformationCard(
//                   title: 'Number of person who takes care about you',
//                   subTitle: '${pPhone}',
//                 ),
//                 InformationCard(
//                   title: 'Doctor',
//                   subTitle: '${doctor}',
//                 ),
//
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: TextButton(
//                       child: Text('Logout'),
//                         onPressed: () {
//                         //TODO: POP the information for the user
//                         Navigator.push(
//                           context,
//                           PageRouteBuilder(
//                             transitionDuration: Duration(seconds: 1),
//                             transitionsBuilder: (BuildContext context,
//                                 Animation<double> animation,
//                                 Animation<double> secAnimation,
//                                 Widget child) {
//                               animation = CurvedAnimation(
//                                   parent: animation, curve: Curves.easeIn);
//                               return ScaleTransition(
//                                 scale: animation,
//                                 child: child,
//                                 alignment: Alignment.center,
//                               );
//                             },
//                             pageBuilder: (BuildContext context,
//                                 Animation<double> animation,
//                                 Animation<double> secAnimation) {
//                               return PatientLogIn();
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
