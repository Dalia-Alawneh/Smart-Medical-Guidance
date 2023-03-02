import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smg_senior/screens/welcome.dart';
import '../Util/RegistrerInfo.dart';

class SecretaryLogIn extends StatefulWidget {
  const SecretaryLogIn({Key? key}) : super(key: key);

  @override
  State<SecretaryLogIn> createState() => _SecretaryLogInState();
}

class _SecretaryLogInState extends State<SecretaryLogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/logo.jpeg',
            width: 100,
            height: 100,
          ),
          Padding(
            padding:EdgeInsets.only(right: 20.0, bottom: 10, top: 20),
            child: Text(
              'تسجيل الدخول للسكرتير',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 25,
                fontFamily: 'Lateef',
              ),
            ),
          ),
          Form(child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              RegisterInfo(info: 'اسم المستخدم',icon:Icon(Icons.person_add_alt)),
              SizedBox(
                height: 10,
              ),
              RegisterInfo(info: 'كلمة المرور',icon:Icon(Icons.key)),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: null,
                child: Card( shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                  color: Color(0xff21A7CC),
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: ListTile(
                    title: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        => Welcome()));
                      },
                      child: Text(
                        'إنشاء حساب',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color:  Colors.white,
                          fontSize: 25,
                          fontFamily: 'Lateef',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: null,
                child: Text('هل نسيت كلمة المرور؟', style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontFamily: 'Lateef',
                ),),
              )
            ],
          ),)
        ],
      ),
    );
  }
}
