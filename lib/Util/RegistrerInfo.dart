import 'package:flutter/material.dart';

class RegisterInfo extends StatelessWidget {
  RegisterInfo({required this.info, required this.icon});
  final info;
  Icon icon;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: TextFormField(
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              filled: true,
              prefixIcon: icon,
              hintStyle: TextStyle(
                color: Color(0xff21A7CC),
                fontFamily: 'Lateef',
                fontSize: 18,
              ),
              hintText: info,
              fillColor: Colors.white),
        ),
      ),
    );
  }
}
