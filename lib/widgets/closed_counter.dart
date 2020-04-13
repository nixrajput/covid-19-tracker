import 'package:covid19counter/constant.dart';
import 'package:flutter/material.dart';

class ClosedCounter extends StatelessWidget {
  final int number;
  final String title;
  final Color color;

  const ClosedCounter({Key key, this.number, this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("$number",
            style: TextStyle(
                fontSize: 24, color: color, fontWeight: FontWeight.bold)),
        Text(title,
            style: TextStyle(
                fontSize: 12,
                color: kBodyTextColor,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
