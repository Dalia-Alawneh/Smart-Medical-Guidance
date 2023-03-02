// import 'dart:collection';
// import 'package:flutter/material.dart';
//
// import 'information.dart';
//
//
//
//
// class Background extends StatelessWidget {
//   final Widget child;
//   final Widget buildBottomNavigationBar;
//   final Name;
//   final birthdate;
//   final phone;
//   final pName;
//   final pPhone;
//   final doctor;
//   final age;
//   const Background({
//      Key? key,
//     required this.child, required this.buildBottomNavigationBar, this.Name,this.phone,this.birthdate,this.pName,this.pPhone,this.doctor, this.age
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       width: double.infinity,
//       height: size.height,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             title: Text('Home Page'),
//             actions: [
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     PageRouteBuilder(
//                       transitionDuration: Duration(seconds: 1),
//                       transitionsBuilder: (BuildContext context,
//                           Animation<double> animation,
//                           Animation<double> secAnimation,
//                           Widget child) {
//                         animation = CurvedAnimation(
//                             parent: animation, curve: Curves.easeIn);
//                         return ScaleTransition(
//                           scale: animation,
//                           child: child,
//                           alignment: Alignment.center,
//                         );
//                       },
//                       pageBuilder: (BuildContext context,
//                           Animation<double> animation,
//                           Animation<double> secAnimation) {
//                         return Information(Name: Name,phone: phone,pName: pName,pPhone: pPhone,birthdate: birthdate,doctor: doctor, age: age,);
//                       },
//                     ),
//                   );
//                 },
//                 child: CircleAvatar(
//                   radius: 20.0,
//                   backgroundImage: AssetImage(
//                     'assets/images/elderly.png',
//                   ),
//                 ),
//               )
//             ],
//           ),
//           body: child,
//           bottomNavigationBar: BottomAppBar(
//             clipBehavior: Clip.antiAlias,
//             notchMargin: 2.0,
//             shape: CircularNotchedRectangle(),
//             child: SizedBox(
//               child: buildBottomNavigationBar,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
