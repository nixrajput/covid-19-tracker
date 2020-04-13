import 'package:covid19counter/constant.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;

  const Counter({
    Key key,
    this.number,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          height: 24.0,
          width: 24.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.25),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 4.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          "$number",
          style: TextStyle(
              fontSize: 22.0, color: color, fontWeight: FontWeight.bold),
        ),
        Text(title, style: kSubTextStyle),
      ],
    );
  }
}
