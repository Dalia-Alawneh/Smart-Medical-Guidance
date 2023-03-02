import 'package:flutter/cupertino.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard(this.appointmentNum, this.appointmentDate);
  final String appointmentNum;
  final String appointmentDate;
  // final String clinicName;
  // final String visitType;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color.fromARGB(222, 35, 35, 35),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          verticalDirection: VerticalDirection.up,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              appointmentNum,
              style: TextStyle(color: Color(0xffffffff)),
            ),
            Text(
              appointmentDate,
              style: TextStyle(color: Color(0xffffffff)),
            ),
            // Text(
            //   clinicName,
            //   style: TextStyle(color: Color(0xffffffff)),
            // ),
            // Text(visitType,
            //     style: TextStyle(color: Color(0xffffffff)))
          ],
        ));
  }
}
//