import 'package:flutter/material.dart';

import '../Util/verifycode.dart';

class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top:15,),
                child: Image.asset(
                  'images/logo.jpeg',
                  width: 100,
                  height: 100,
                ),
              ),
              Padding(
                padding:EdgeInsets.only( bottom: 15, top: 15,right: 5),
                child: Text(
                  'أدخل رمز التحقق الذي قمنا بإرساله عبر رسائل SMS :',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color:  Color(0xff21A7CC),
                    fontSize: 30,
                    fontFamily: 'Lateef',
                  ),
                ),
              ),
              VerifyCode(),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical:0),
                      decoration: BoxDecoration(
                        color: Color(0xff21A7CC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text('إعادة الإرسال',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Lateef',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('لم تتلق رمز؟',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color:  Color(0xff21A7CC),
                        fontSize: 22,
                        fontFamily: 'Lateef',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}