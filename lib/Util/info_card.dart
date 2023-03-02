import 'package:flutter/material.dart';
class InformationCard extends StatelessWidget {
  final String title;
  final String subTitle;

  InformationCard({required this.subTitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: ListTile(
        title: Text('${title}:'),
        subtitle: Text(subTitle),
      ),
    );
  }
}