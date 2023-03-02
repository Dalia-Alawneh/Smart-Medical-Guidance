import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicsList extends StatefulWidget {
  const ClinicsList({super.key});

  @override
  State<ClinicsList> createState() => _ClinicsListState();
}

class _ClinicsListState extends State<ClinicsList> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 30),
          children: const [
            Text(
              "قائمة العيادات",
              style: TextStyle(
                  color: Color.fromARGB(255, 17, 132, 219), fontSize: 22),
            ),

            ClinicCard(
                'عيادة د. محمد جابر', 'أنف, أذن, حنجرة', 'جنين - شارع الحسبة'),
            ClinicCard(
                'عيادة د. محمد جابر', 'أنف, أذن, حنجرة', 'جنين - شارع الحسبة'),
            ClinicCard(
                'عيادة د. محمد جابر', 'أنف, أذن, حنجرة', 'جنين - شارع الحسبة'),
            ClinicCard(
                'عيادة د. محمد جابر', 'أنف, أذن, حنجرة', 'جنين - شارع الحسبة'),
            ClinicCard(
                'عيادة د. محمد جابر', 'أنف, أذن, حنجرة', 'جنين - شارع الحسبة'),
          ],
        ),
      ),
    );
  }
}

class ClinicCard extends StatelessWidget {
  const ClinicCard(this.clinicName, this.clinicSpecialize, this.clinicLocation);
  final String clinicName;
  final String clinicSpecialize;
  final String clinicLocation;
  @override
  Widget build(BuildContext context) {
    List<Map<String, List<String>>> clinicsWithSymptoms = [
      {
        'General_clinic':['Fatigue', 'Hand or finger pain', 'Knee lump or mass', 'Eye strain','Excessive growth',
          'Pelvic pressure','Bedwetting', 'Vulvar sore','Fever', 'Sharp chest pain', 'Tension headache']
      },
      {
        'Bones_clinic':['Problems with movemen', 'Bones are painful', 'Chronic knee pain', 'Hip pain','Hurts to breath','Ache all over',
          'Low back pain', 'Joint pain','Vomiting', 'Arm weakness', 'Fatigue']
      },
      {
        'Ear_nose_throat_clinic':['Bleeding from ear', 'Sore throat', 'Diminished hearing', 'Coryza','Nasal congestion','Hoarse voice',
          'Lack of growth', 'Sinus congestion','Chronic sinusitis ', 'Lump in throat', 'Ringing in ear']
      },
      {
        'Neurologists_clinic':['Panic disorder', 'Irregular heartbeat', 'Palpitations', 'Fatigue','Difficulty breathing','Hip pain',
          'Headache', 'Abnormal involuntary movements','Weakness ', 'Skin rash', 'Vomiting']
      },
      {
        'Internal clinic':['Nausea', 'Sharp abdominal pain', 'Hurts to breath', 'Infant feeding problem','Loss of sensation','Pain of the anus',
          'Headache', 'Vomiting blood','Weight gain ', 'Skin rash', 'Frequent urination']
      },
    ];
    List<List<String>> clinics = [
      ['Haifa Kamel Mousa', 'General clinic'],
      ['Mathna Jabarin', 'General clinic'],
      ['Jarir Albarri', 'Bones clinic'],
      ['Naser Ata Jafar', 'Ear, nose and throat clinic'],
      ['Tatania and saeed Jayousi', 'Neurologists clinic'],
      ['Arafat  Zakarneh', 'Bones clinic'],
      ['Mustafa Naser Hamarsheh', 'Internal clinic'],
      ['Omar Abd Alghani', 'Bones clinic'],
      ['Tariq Khalaf', 'Bones clinic'],
      ['Yazeed Abd Alhaleem Jayosui', 'Ear, nose and throat clinic'],
      ['Khalid Faisal Summour', 'Ear, nose and throat clinic'],
      ['Mohamed Ahmed Jaber', 'Ear, nose and throat clinic'],
      ['Khalid Shafeea Soliman', 'Ear, nose and throat clinic'],
    ];
    return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color.fromARGB(222, 35, 35, 35),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              clinicName,
              style: TextStyle(color: Color(0xffffffff)),
            ),
            Text(
              clinicSpecialize,
              style: TextStyle(color: Color(0xffffffff)),
            ),
            Text(
              clinicLocation,
              style: TextStyle(color: Color(0xffffffff)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.star, color: Color(0xffffffff)),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 17, 132, 219),
                ),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 17, 132, 219),
                ),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 17, 132, 219),
                ),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 17, 132, 219),
                ),
              ],
            )
          ],
        ));
  }
}
