import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MyHeader extends StatefulWidget {
  final String image;
  const MyHeader(
      {Key?key, required this.image,})
      : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
       // margin: EdgeInsets.only(bottom:20,top: 5),
      // padding: EdgeInsets.only(left: 40, top: 50, right: 20,),
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff2894B1),
          // gradient: LinearGradient(
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   colors: [
          //     Colors.white,
          //     Color(0xff1E90FF),
          //     Color(0xff2894B1),
          //   ],
          // ),
          image: DecorationImage(
            image: AssetImage(widget.image),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}