import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyCode extends StatefulWidget {
  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final _boxController1 = TextEditingController();
  final _boxController2 = TextEditingController();
  final _boxController3 = TextEditingController();
  final _boxController4 = TextEditingController();


  final _boxFocus1 = FocusNode();
  final _boxFocus2 = FocusNode();
  final _boxFocus3 = FocusNode();
  final _boxFocus4 = FocusNode();


  late List<TextEditingController> _controllers;
  late List<FocusNode> _focus;
  late TextEditingController _selectedController;
  late FocusNode _selectedFocus;

  String _value = '';

  @override
  void initState() {
    super.initState();
    _controllers = [
      _boxController1,
      _boxController2,
      _boxController3,
      _boxController4,
    ];
    _focus = [
      _boxFocus1,
      _boxFocus2,
      _boxFocus3,
      _boxFocus4,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate( 4,
            (index) => GestureDetector(
          onTap: () {
            if (_value.isEmpty) {
              setState(() {
                _selectedFocus = _focus[0];
                _selectedController = _controllers[0];
              });
              FocusScope.of(context).requestFocus(_selectedFocus);
            } else {
              setState(() {
                _selectedFocus = _focus[index];
                _selectedController = _controllers[index];
              });
              FocusScope.of(context).requestFocus(_selectedFocus);
            }
            print(_selectedController.text);
          },
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 25,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                width: 25,
                height: 25,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focus[index],
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
                  ],
                  onTap: () {
                    if (_value.isEmpty) {
                      setState(() {
                        _selectedFocus = _focus[0];
                        _selectedController = _controllers[0];
                      });
                      FocusScope.of(context).requestFocus(_selectedFocus);
                    }
                  },
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      if (val.length > 1) {
                        _selectedController.clear();
                        setState(() {
                          _selectedController.text = val.split('').last;
                        });
                      }
                      setState(() {
                        _value = _controllers.fold<String>(
                            '', (prevVal, element) => prevVal + element.text);
                      });
                      if (index + 1 < _focus.length) {
                        _selectedFocus = _focus[index + 1];
                        _selectedController = _controllers[index + 1];
                        FocusScope.of(context).requestFocus(_selectedFocus);
                      } else {
                        FocusScope.of(context).unfocus();
                        _selectedFocus = _focus[0];
                        _selectedController = _controllers[0];
                      }
                    }
                    print(_value);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}