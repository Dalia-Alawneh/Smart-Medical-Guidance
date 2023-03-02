import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:smg_senior/main.dart';
import 'dart:math' as math;

import 'RegisterLogin.dart';
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this,
      duration: Duration(seconds: 5))..forward();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 6),
            ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MainHome())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder( builder: (context, orientation){
        return Center(
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _controller,
                child: Image(image: AssetImage(
                    'images/cycle.png'
                )),
                builder: (BuildContext context, Widget? child){
                  return Transform.rotate(
                      angle: _controller.value * 2 * math.pi,
                      child:child
                  );
                },

              ),
              Positioned(
                  top: orientation == Orientation.landscape? 88 :86,
                  left: orientation == Orientation.landscape?
                  MediaQuery.of(context).size.width/5.9: MediaQuery.of(context).size.width/3.3,
                  child:
                  Column(
                    children: [
                      AvatarGlow(
                        glowColor: Color(0xff21A7CC),
                        endRadius:70,
                        duration:Duration(seconds: 1),
                        repeat:true,
                        showTwoGlows: true,
                        curve: Curves.easeOutQuad,
                        child: Image(
                          width: 80.0,
                          image: AssetImage('images/mic.png'),),
                      ),
                      Text('SMG', style: TextStyle(
                          color: Color(0xff21A7CC),
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                      ),),
                      Text('Smart Medical Guidance',
                        style: TextStyle(
                          color:  Color(0xff21A7CC),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        );
      }
      ),
    );
  }
  @override
  void dispose() {
    // _WelcomeState.dispose();
    _controller.dispose();
    super.dispose();

  }
}
