import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClinicDates extends StatefulWidget {
  const ClinicDates({super.key});

  @override
  State<ClinicDates> createState() => _ClinicDatesState();
}

class _ClinicDatesState extends State<ClinicDates> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 40),
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: const[
                  Text(
                    ' عيادة الدكتور سمير عتيق',
                    style: TextStyle(
                        color: Color.fromARGB(255, 17, 132, 219), fontSize: 30),
                  ),
                  Text(
                    'اختر الوقت الذي يناسبك',
                    style: TextStyle(
                        color: Color.fromARGB(255, 17, 132, 219), fontSize: 20),
                  ),
                ],
              ),
            ),
            ClinicDatesCard(
              '9:00 AM',
              //ElevatedButton(onPressed: (){}, child: Text("حجز")),
            ),
            ClinicDatesCard(
              '10:00 AM',
              //ElevatedButton(onPressed: (){}, child: Text("حجز")),
            ),
            ClinicDatesCard(
              '11:00 AM',
              //ElevatedButton(onPressed: (){}, child: Text("حجز")),
            ),
            ClinicDatesCard(
              '12:00 PM',
              //ElevatedButton(onPressed: (){}, child: Text("حجز")),
            ),
            ClinicDatesCard(
              '1:00 PM',
              //ElevatedButton(onPressed: (){}, child: Text("حجز")),
            ),
          ],
        ),
      ),
    );
  }
}

class ClinicDatesCard extends StatelessWidget {
  const ClinicDatesCard(
      this.ClinicDatesTime,
      //this.ConfirmButton,
      );
  final String ClinicDatesTime;
  //final ElevatedButton ConfirmButton;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color.fromARGB(222, 35, 35, 35),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              ClinicDatesTime,
              style: TextStyle(color: Color(0xffffffff), fontSize: 21),
            ),
          ],
        ));
  }
}
