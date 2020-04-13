import 'dart:async';

import 'package:covid19counter/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHeader extends StatelessWidget {
  final String image;
  final String textTop;
  final String textBottom;

  const MyHeader({
    Key key,
    this.image,
    this.textTop,
    this.textBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 16.0, top: 64.0, right: 16.0),
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF662D8C),
              Color(0xFFED1E79),
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/virus.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  addDialog(context);
                },
                child: SvgPicture.asset("assets/icons/info.svg"),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Stack(
                children: <Widget>[
                  SvgPicture.asset(
                    image,
                    width: 240.0,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                  Positioned(
                    top: 32.0,
                    left: 160.0,
                    child: Text(
                      "$textTop \n$textBottom",
                      style: kHeadingTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future addDialog(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    await showDialog(
        context: context,
        child: SimpleDialog(
          title: Text(
            "COVID-19 Tracker",
            style: kTitleTextStyle,
            textAlign: TextAlign.center,
          ),
          elevation: 16.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          titlePadding:
              EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Version:  ",
                  style: kKeyTextStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  version + " (" + buildNumber + ")",
                  style: kInfoTextStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Developer:  ",
                  style: kKeyTextStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "NiX Rajput",
                  style: kInfoTextStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            GestureDetector(
              onTap: () async {
                if (await canLaunch("https://github.com/nixrajput")) {
                  await launch("https://github.com/nixrajput");
                }
              },
              child: Text(
                "(Follow Me)",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "©2020 CodeX Society",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
          contentPadding:
              EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 16.0),
        ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80.0);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80.0);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
