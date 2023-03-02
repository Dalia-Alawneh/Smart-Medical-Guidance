// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:smg_senior/Util/destination.dart';

// class ClinicName extends StatefulWidget {
//   ClinicName({required this.clinic});
//   late String clinic;

//   @override
//   State<ClinicName> createState() => _ClinicNameState();
// }

// class _ClinicNameState extends State<ClinicName> {
//   List<Destination> destinations=[];
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         stream: FirebaseFirestore.instance
//             .collection('Clinics')
//             .where('Clinic type', isEqualTo: widget.clinic)
//             .snapshots(),
//         builder: (_, snapshot) {
//           if (snapshot.hasError) return Text('Error = ${snapshot.error}');
//           if (snapshot.hasData) {
//             final docs = snapshot.data!.docs;
//             return ListView.builder(
//               itemCount: docs.length,
//               itemBuilder: (_, i) {
//                 final data = docs[i].data();
//                 Destination destination = Destination(
//                     data['lat'], data['lag'], data['Clinic name'],
//                     distance: 0);
                    
//                 destinations.add(destination);
//                 // print(destination);
//                 //  if (data['Clinic type'] == widget.clinic) {
//                 return ListTile(
//                   title: Text(data['Clinic name']),
//                   subtitle: Text(data['Clinic type']),
//                 );
//                 // } else {
//                 //   return Text('');
//                 // }
//               },
//             );
//           }
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//     // return Scaffold(
//     //     body: Center(
//     //         child: Text(widget.clinic == 'عيادة داخلية'
//     //             ? 'عيادة باطنية'
//     //             : widget.clinic)));
//   }
// }
