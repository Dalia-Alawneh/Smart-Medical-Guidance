import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../Util/RegistrerInfo.dart';

enum SingingCharacter { Type1, Type2 }

class DoctorRegisterNextStep extends StatefulWidget {
  const DoctorRegisterNextStep({Key? key}) : super(key: key);

  @override
  State<DoctorRegisterNextStep> createState() => _DoctorRegisterNextStepState();
}

class _DoctorRegisterNextStepState extends State<DoctorRegisterNextStep> {
  final GlobalKey<SlideActionState> _key = GlobalKey();
  SingingCharacter? _character = SingingCharacter.Type1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 15,
            ),
            child: Image.asset(
              'images/logo.jpeg',
              width: 100,
              height: 100,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0, bottom: 10),
            child: Text(
              'إنشاء حساب للطبيب',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Color(0xff21A7CC),
                fontSize: 25,
                fontFamily: 'Lateef',
              ),
            ),
          ),
          Form(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            enabled: false,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                  color: Color(0xff21A7CC),
                                  fontFamily: 'Lateef',
                                  fontSize: 18,
                                ),
                                hintText: '1',
                                fillColor: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            enabled: false,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.idCard,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                  color: Color(0xff21A7CC),
                                  fontFamily: 'Lateef',
                                  fontSize: 18,
                                ),
                                hintText: 'الرقم التعريفي الخاص بالعيادة',
                                fillColor: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RadioGroup(),
                    Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Container(
                          width: 60,
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'الصنف',
                            style: new TextStyle(
                              fontSize: 18.0,
                              color: Color(0xff21A7CC),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                RegisterInfo(
                    info: 'الاختصاص', icon: Icon(Icons.type_specimen_outlined)),
                SizedBox(
                  height: 10,
                ),
                RegisterInfo(
                    info: 'الموقع',
                    icon: Icon(
                      Icons.location_on,
                    )),
                SizedBox(
                  height: 10,
                ),
                RegisterInfo(
                    info: 'الوصف', icon: Icon(Icons.description_outlined)),
                SizedBox(
                  height: 10,
                ),
                RegisterInfo(
                    info: 'رقم الهوية الخاص بالسكرتير',
                    icon: Icon(
                      FontAwesomeIcons.idCard,
                      size: 18,
                    )),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: null,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Color(0xff21A7CC),
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: ListTile(
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorRegisterNextStep()));
                        },
                        child: Text(
                          'إنشاء حساب العيادة',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Lateef',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RadioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class RadioGroupWidget extends State {
  String radioButtonItem = 'ONE';
  int id = 1;
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: id,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem = 'TYPEONE';
                    id = 1;
                  });
                },
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                  width: 70,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'خاص',
                    style: new TextStyle(
                      fontSize: 18.0,
                      color: Color(0xff21A7CC),
                    ),
                  ),
                ),
              ),
              Radio(
                value: 2,
                groupValue: id,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem = 'TYPETWO';
                    id = 2;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    width: 70,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'عام',
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: Color(0xff21A7CC),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
