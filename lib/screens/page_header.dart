import 'package:flutter/material.dart';
class PageHeader extends StatelessWidget {
  const PageHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:25, bottom: 5),
      child: Image.asset(
        'images/logo.jpeg',
        width: 130,
        height: 130,
      ),
    );
  }
}
