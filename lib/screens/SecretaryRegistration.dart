import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Util/RegistrerInfo.dart';
import 'SecretaryRegisterNextStep.dart';

class SecretaryRegistration extends StatefulWidget {
  const SecretaryRegistration({Key? key}) : super(key: key);

  @override
  State<SecretaryRegistration> createState() => _SecretaryRegistrationState();
}

class _SecretaryRegistrationState extends State<SecretaryRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
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
            padding:EdgeInsets.only(right: 20.0, bottom: 10),
            child: Text(
              'إنشاء حساب للسكرتير',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color:  Color(0xff21A7CC),
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
              RegisterInfo(info: 'رقم التعريف الخاص بالعيادة',icon:Icon(FontAwesomeIcons.idCard, size: 18,)),
              SizedBox(
                height: 10,
              ),
              RegisterInfo(info: 'رقم الهوية الخاص بك',icon:Icon(FontAwesomeIcons.idCard, size: 18,)),
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
                        => SecretaryRegistrNextStep()));
                      },
                      child: Text(
                        'متابعه',
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
            ],
          ),)
        ],
      ),
    );
  }
}
