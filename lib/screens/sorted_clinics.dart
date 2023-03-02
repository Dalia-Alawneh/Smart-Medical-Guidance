// // import 'dart:html';
// import 'dart:ui';

// import 'package:blur/blur.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:smg_senior/Util/bottom_bar.dart';
// import 'package:smg_senior/Util/colors.dart';
// import 'package:smg_senior/screens/clinicProfile.dart';
// import 'package:smg_senior/screens/clinicProfileForUsers.dart';

// import '../Util/destination.dart';

// const double _minHeight = 200;
// const double _maxHeight = 635;

// class MyHomePage extends StatefulWidget {
//   MyHomePage({required this.clinic});
//   late String clinic;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
//   LatLng startingLocation = LatLng(-2.142869, -79.923845);
//   final currentLocation = TextEditingController();
//   late GoogleMapController _mapController;
//   late AnimationController _animationController;
//   double _currentHeight = _minHeight;
//   dynamic user;
//   @override
//   void initState() {
//     getClinics();
//     // getUser();
//     // getUserLocation();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 675),
//     );
//     super.initState();
//   }

//   Future getUser() async {
//     dynamic currentUser = await FirebaseAuth.instance.currentUser;
//     if (currentUser.displayName == 'doctor') {
//       print('hhh');
//       user = await FirebaseFirestore.instance
//           .collection('Doctors')
//           .where('uid', isEqualTo: currentUser.uid)
//           .get()
//           .then((value) => value.docChanges);
//       print(user);
//     }
//     print(currentUser.uid);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void onCreated(GoogleMapController mapController) {
//     _mapController = mapController;
//   }

//   late Position _currentPosition;
//   List<Destination> destinationlist = <Destination>[];
//   var destinations = [];
//   // var destinations = [
//   //   Destination(32.46833677997933, 35.286993819076216, "مستشفى ابن سينا",
//   //       distance: 0),
//   //   Destination(32.46175298372068, 35.295692696859746, "مستشفى الشفاء الجراحي",
//   //       distance: 0),
//   //   Destination(32.458584860588445, 35.300938794174094, "مستشفى الرازي",
//   //       distance: 0),
//   //   Destination(32.46463798327884, 35.29385899525138, "مستشفى الحكومي",
//   //       distance: 0),
//   // ];
//   Future getClinics() async {
//     // widget.clinic == "عيادة داخلية" ? "عيادة باطنية" : widget.clinic;
//     var clinics = FirebaseFirestore.instance
//         .collection('Clinics')
//         .where("Clinic type", isEqualTo: widget.clinic)
//         .get()
//         .then((data) {
//       // use ds as a snapshot
//       print(data.docs);
//       if (data.size > 0) {
//         setState(() {
//           for (int i = 0; i < data.size; i++) {
//             var clinic = data.docChanges[i].doc.data();
//             print(clinic!['Clinic type']);
//             //  print(data.docChanges[i].doc.id);
//             // if (clinic!['Clinic type'] == widget.clinic) {
//             print(clinic['clinicID']);
//             Destination d = Destination(
//               clinic!['lat'],
//               clinic['lag'],
//               clinic['Clinic name'],
//               clinic['clinicID'],
//               distance: 0,
//             );
//             print(d.lat);
//             destinationlist.add(d);
//             // }
//           }
//           destinations.map((destination) => {print(destination)});
//           // print(data.docChanges[1].doc.data());
//         });
//       }
//     });
//     _getCurrentLocation();
//     // print(ds.whenComplete(() => null));
//   }

//   _getCurrentLocation() async {
//     bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
//     print(isLocationServiceEnabled);
//     if (!isLocationServiceEnabled) {
//       LocationPermission permission;
//       permission = await Geolocator.requestPermission();
//     }
//     print('hh');
//     await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.best,
//             forceAndroidLocationManager: true)
//         .then((Position position) {
//       distanceCalculation(position);
//       setState(() {
//         _currentPosition = position;
//       });
//     }).catchError((e) async {
//       LocationPermission permission;
//       permission = await Geolocator.requestPermission();
//       print(e);
//     });
//   }

//   distanceCalculation(Position position) {
//     setState(() {
//       for (var d in destinationlist) {
//         //var m = Geolocator.distanceBetween(position.latitude,position.longitude, d.lat,d.lng);
//         double distanceInMeters = Geolocator.distanceBetween(
//             position.latitude, position.longitude, d.lat, d.lng);
//         d.distance = distanceInMeters;
//         print(d.distance);
//         destinations.add(d);
//         print(d.id);
//       }
//       destinationlist.sort((a, b) {
//         return a.distance.compareTo(b.distance);
//       });
//       setState(() {});
//       print(destinationlist);
//     });
//   }

//   // void getUserLocation() async {
//   //   Position position = await Geolocator()
//   //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   //   List<Placemark> placemark = await Geolocator()
//   //       .placemarkFromCoordinates(position.latitude, position.longitude);
//   //   startingLocation = LatLng(position.latitude, position.longitude);
//   //   currentLocation.text = placemark[0].name;
//   //   _mapController.animateCamera(CameraUpdate.newLatLng(startingLocation));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         key: _scaffoldkey,
//         body: Stack(
//           fit: StackFit.loose,
//           children: [
//             // Padding(
//             //   padding: const EdgeInsets.only(bottom: 0),
//             //   child: GoogleMap(
//             //     initialCameraPosition:
//             //         CameraPosition(target: startingLocation, zoom: 15),
//             //     myLocationEnabled: true,
//             //     myLocationButtonEnabled: false,
//             //     zoomControlsEnabled: false,
//             //     onMapCreated: onCreated,
//             //   ),
//             // ),
//             Container(
//                 height: double.infinity,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: NetworkImage(
//                           'https://www.umhs-adolescenthealth.org/wp-content/uploads/2016/12/google-map-background.jpg')),
//                 )),

//             Positioned(
//               bottom: MediaQuery.of(context).size.height / 3.4,
//               right: 15,
//               child: FloatingActionButton(
//                 mini: true,
//                 onPressed: () {},
//                 backgroundColor: Colors.white,
//                 child: Icon(
//                   Icons.gps_fixed,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 60,
//               left: 20,
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 maxRadius: 22,
//                 child: IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.menu,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onVerticalDragUpdate: (details) {
//                 setState(() {
//                   final newHeight = _currentHeight - details.delta.dy;
//                   _animationController.value = _currentHeight / _maxHeight;
//                   _currentHeight = newHeight.clamp(0.0, _maxHeight);
//                 });
//               },
//               onVerticalDragEnd: (details) {
//                 if (_currentHeight < _maxHeight / 1.4) {
//                   setState(() {
//                     _animationController.reset();
//                     _currentHeight = _minHeight;
//                   });
//                 } else {
//                   setState(() {
//                     _animationController.forward(
//                         from: _currentHeight / _maxHeight);
//                     _currentHeight = _maxHeight;
//                   });
//                 }
//               },
//               child: AnimatedBuilder(
//                   animation: _animationController,
//                   builder: (context, snapshot) {
//                     final value = _animationController.value;
//                     return Stack(
//                       children: [
//                         Positioned(
//                           height: lerpDouble(_minHeight, _maxHeight, value),
//                           bottom: 0,
//                           left: 0,
//                           right: 0,
//                           child: _draggable(),
//                         )
//                       ],
//                     );
//                   }),
//             ),
//             AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, snapshot) => Positioned(
//                 left: 0,
//                 right: 0,
//                 top: -182 * (1 - _animationController.value),
//                 child: Container(height: 180, child: _appBar()),
//               ),
//             ),
//             // AnimatedBuilder(
//             //   animation: _animationController,
//             //   builder: (context, snapshot) => Positioned(
//             //     left: 0,
//             //     right: 0,
//             //     bottom: -52 * (1 - _animationController.value),
//             //     // child: BottomBar(),
//             //   ),
//             // ),
//           ],
//         ),
//         drawer: MyDrawer(),
//         drawerEnableOpenDragGesture: true,
//       ),
//     );
//   }

//   Widget _appBar() {
//     return AppBar(
//       iconTheme: IconThemeData(color: Colors.black),
//       title: Text(
//         ' معلومات عن الموقع الجغرافي ',
//         style: TextStyle(
//           fontSize: 18.0,
//           color: KColor.secBlueColor,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         icon: Icon(Icons.close),
//         onPressed: () {
//           setState(() {
//             _animationController.reverse();
//             _currentHeight = 0.0;
//           });
//         },
//       ),
//       bottom: PreferredSize(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 21.5),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(right: 30),
//                 child: Row(
//                   children: [
//                     Icon(
//                       color: Colors.green,
//                       Icons.gps_fixed,
//                       size: 25,
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Text(
//                       "جنين",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 9,
//               ),
//               Container(
//                 padding: EdgeInsets.only(right: 30, bottom: 15),
//                 child: Row(
//                   children: [
//                     Icon(
//                       color: KColor.lightBlueColor,
//                       Icons.fmd_good_sharp,
//                       size: 25,
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Text(
//                       "البعد عن اقرب عيادة",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ],
                  
//                 ),
//               ),
//             ],
//           ),
//         ),
//         preferredSize: Size.fromHeight(80.0),
//       ),
//     );
//   }

//   Widget _draggable() {
//     return ClipRect(
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//             margin: EdgeInsets.only(top: 2),
//             //height: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color.fromARGB(118, 255, 255, 255),
//                     Color.fromARGB(58, 255, 255, 255)
//                   ]),
//               // color: Color.fromRGBO(255, 255, 255, 0.4),
//               boxShadow: [
//                 BoxShadow(
//                   blurStyle: BlurStyle.outer,
//                   color: Color.fromARGB(81, 0, 0, 0),
//                   offset: Offset(0, 1),
//                   blurRadius: 1,
//                 ),
//               ],
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15.0),
//                 topRight: Radius.circular(15.0),
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(10.0),
//                   width: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     color: KColor.secBlueColorWithOpacity,
//                   ),
//                   height: 3.5,
//                 ),
//                 _searchButton(),
//                 destinations.length > 0
//                     ? Expanded(
//                         child: ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: destinations.length,
//                             itemBuilder: (context, index) {
//                               return Expanded(
//                                 child: LocationListTile(
//                                     destinationlist[index].name,
//                                     "${destinationlist[index].distance.toStringAsFixed(2)} m",
//                                     index+1, () {
//                                   setState(() {
//                                     print(destinationlist[index].id);
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ClinicProfileForUsers(
//                                                   cid:
//                                                       destinationlist[index].id,
//                                                 )));
//                                   });
//                                 }),
//                               );
//                             }),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.only(top: 30.0),
//                         child: CircularProgressIndicator(),
//                       ),
//                 // LocationListTile('Enter home location', Icons.home),
//                 // LocationListTile('Enter work location', Icons.work),
//               ],
//             )),
//       ),
//     );
//   }

//   Widget _searchButton() {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _animationController.forward(from: _currentHeight / _maxHeight);
//           _currentHeight = _maxHeight;
//         });
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width / 1.1,
//         alignment: Alignment.center,
//         padding: EdgeInsets.only(left: 10.0, top: 15),
//         child: Text(
//           ' العيادات القريبة من منطقتك ',
//           textAlign: TextAlign.right,
//           style: TextStyle(
//               fontSize: 17.5,
//               fontWeight: FontWeight.bold,
//               color: KColor.secBlueColor),
//         ),
//       ),
//     );
//   }
// }

// class LocationListTile extends StatelessWidget {
//   final String head;
//   final String destance;
//   final int num;
//   final Function onTap;
//   LocationListTile(
//     this.head,
//     this.destance,
//     this.num,
//     this.onTap,
//   );
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap as VoidCallback,
//       child: ClipRect(
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//             padding: const EdgeInsets.all(15),
//             decoration: BoxDecoration(boxShadow: [
//               BoxShadow(
//                 blurStyle: BlurStyle.inner,
//                 blurRadius: 5,
//                 color: KColor.secBlueColorWithOpacity,
//                 // offset: Offset(3, 2))
//               )
//             ], borderRadius: BorderRadius.circular(10)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: Text(
//                           '$num',
//                           style: TextStyle(
//                               color: KColor.secBlueColorWithOpacity,
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold),
//                         )),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Text(
//                       head,
//                       style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w900),
//                     )
//                   ],
//                 ),
//                 Text(
//                   '$destance',
//                   style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w900),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width / 1.2,
//       color: Colors.white,
//       child: ListView(
//         children: [
//           UserAccountsDrawerHeader(
//             accountName: Text(
//               'Luis Arce',
//               style: TextStyle(
//                 fontSize: 15.5,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             accountEmail: Text('lapcomtab@gmail.com'),
//             currentAccountPicture: ClipRRect(
//               borderRadius: BorderRadius.circular(80),
//               child: Image(
//                 image: NetworkImage(
//                     'https://yt3.ggpht.com/ytc/AAUvwni7ZSUh5z0QnkoBgdnRRFNb2AlXsTy8CWXmkME6qw=s88-c-k-c0x00ffffff-no-rj'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('My account'),
//             leading: Icon(Icons.person),
//           ),
//           ListTile(
//             title: Text('Settings'),
//             leading: Icon(Icons.settings),
//           ),
//           ListTile(
//             title: Text('Help'),
//             leading: Icon(Icons.help),
//           ),
//           ListTile(
//             title: Text('Support'),
//             leading: Icon(Icons.forum),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PickPlaceMap extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black54, offset: Offset(-1, 0), blurRadius: 2.0)
//         ],
//       ),
//       padding: const EdgeInsets.all(10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.place_sharp,
//             color: Colors.grey,
//           ),
//           SizedBox(
//             width: 10.0,
//           ),
//           Text(
//             ' Choose on map',
//             style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500),
//           )
//         ],
//       ),
//     );
//   }
// }
