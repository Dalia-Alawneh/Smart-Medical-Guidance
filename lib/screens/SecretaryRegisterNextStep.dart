import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smg_senior/screens/welcome.dart';
import '../Util/RegistrerInfo.dart';

class SecretaryRegistrNextStep extends StatefulWidget {
  const SecretaryRegistrNextStep({Key? key}) : super(key: key);

  @override
  State<SecretaryRegistrNextStep> createState() => _SecretaryRegistrNextStepState();
}

class _SecretaryRegistrNextStepState extends State<SecretaryRegistrNextStep> {
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
              'تم قبولك، تابع إنشاء حسابك',
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
              Row(
                children: [
                  Flexible(child: RegisterInfo(info: 'الاسم الثاني', icon:Icon(Icons.person),)),
                  Flexible(child: RegisterInfo(info: 'الاسم الأول', icon:Icon(Icons.person))),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(child: RegisterInfo(info: 'الاسم الرابع',icon:Icon(Icons.person)),),
                  Flexible(child: RegisterInfo(info: 'الاسم الثالث',icon:Icon(Icons.person))),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RegisterInfo(info: 'اسم المستخدم',icon:Icon(Icons.person_add_alt)),
              SizedBox(
                height: 10,
              ),
              RegisterInfo(info: 'رقم الهاتف',icon:Icon(Icons.phone_enabled)),
              SizedBox(
                height: 10,
              ),
              RegisterInfo(info: 'تاريخ الميلاد',icon:Icon(Icons.calendar_month_sharp)),
              SizedBox(
                height: 10,
              ),
              RegisterInfo(info: 'نبذة تعريفية',icon:Icon(Icons.text_snippet_outlined)),
              SizedBox(
                height: 10,
              ),
              RegisterInfo(info: 'كلمة المرور',icon:Icon(Icons.key)),
              SizedBox(
                height: 10,
              ),
              RegisterInfo(info: 'تأكيد كلمة المرور',icon:Icon(Icons.key)),
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
            ],
          ),)
        ],
      ),
    );
  }
}
