import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ClcID with ChangeNotifier {
  dynamic clcID;
  final user = FirebaseAuth.instance.currentUser;
  dynamic get clinic_ID => clcID;
  Future getId() async {
    var clinic;
    await FirebaseFirestore.instance
        .collection('Clinics')
        .where("docID", isEqualTo: user!.uid)
        .get()
        .then((data) {
      // clinic = data.docChanges.first.doc.data();
      data.docs.forEach((element) {
        clcID = element['clinicID'];
        print(clcID);
      });
    });

    notifyListeners();
  }
}
