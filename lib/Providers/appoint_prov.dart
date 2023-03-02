import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Appoint with ChangeNotifier {
  String clinicName = "";
  String clinicType = 'عيادة خاصة';
  List clinics = [];
  
  String get clinic_name => clinicName;
  String get clinic_type => clinicType;
  List get all_clinics => clinics;
  Future getName(int id) async {
    print(id);
    var clinic;
    await FirebaseFirestore.instance
        .collection('Clinics')
        .where("clinicID", isEqualTo: id)
        .get()
        .then((data) {
      // clinic = data.docChanges.first.doc.data();
      data.docs.forEach((element) {
        // print(
        clinicName = element['Clinic name'];
        clinicType = element['Clinic type'];
      });
      // clinics.add(clinic);
      // print(clinic);
    });
    // clinicName = clinic["Clinic name"];
    // clinicType = clinic['Clinic type'];
    notifyListeners();
  }
}
