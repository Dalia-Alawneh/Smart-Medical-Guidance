// import 'package:flutter/material.dart';
// import 'Util/background.dart';
//
// class Body extends StatefulWidget {
//   final Name;
//   final birthdate;
//   final phone;
//   final pName;
//   final pPhone;
//   final doctor;
//   final vid;
//
//   Body({ this.Name,this.birthdate,this.pPhone,this.pName,this.phone,this.doctor,this.vid});
//
//   @override
//   _BodyState createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   int _currentIndex = 0;
//
//
//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   // final List<Widget> _children = [
//   //   PlaceholderWidget(RecentResult()),
//   //   PlaceholderWidget(AllResult()),
//   //   PlaceholderWidget(Setting()),
//   //
//   // ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       phone: widget.phone,
//       pPhone: widget.pPhone,
//       pName: widget.pName,
//       Name: widget.Name,
//       doctor: widget.doctor,
//       birthdate: widget.birthdate,
//       child:Text('Current index'),
//       buildBottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         //backgroundColor: kPrimaryColor,
//         onTap: onTabTapped, // new
//         currentIndex: _currentIndex, // new
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history_toggle_off),
//             label: 'Health History',
//
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
