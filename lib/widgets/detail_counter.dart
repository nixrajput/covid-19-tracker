import 'package:covid19counter/constant.dart';
import 'package:flutter/material.dart';

class DetailCounter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;

  const DetailCounter({Key key, this.number, this.color, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(title,
            style: TextStyle(
              fontSize: 16,
              color: kBodyTextColor,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: 2.0,
        ),
        Text("$number",
            style: TextStyle(
              fontSize: 30,
              color: color,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}
