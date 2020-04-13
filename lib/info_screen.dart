import 'package:covid19counter/constant.dart';
import 'package:covid19counter/widgets/my_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/doctor1.svg",
              textTop: "Know About",
              textBottom: "  COVID - 19",
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Symptoms",
                    style: kTitleTextStyle,
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SymptomCard(
                        image: "assets/images/headache.png",
                        title: "Headache",
                        isActive: true,
                      ),
                      SymptomCard(
                        image: "assets/images/caugh.png",
                        title: "Caugh",
                      ),
                      SymptomCard(
                        image: "assets/images/fever.png",
                        title: "Fever",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SymptomCard(
                        image: "assets/images/sore_throat.png",
                        title: "Sore Throat",
                        isActive: true,
                      ),
                      SymptomCard(
                        image: "assets/images/breathe_diff.png",
                        title: "Breathing",
                      ),
                      SymptomCard(
                        image: "assets/images/weakness.png",
                        title: "Weakness",
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  Text("Prevention", style: kTitleTextStyle),
                  SizedBox(height: 16.0),
                  PreventCard(
                    text:
                        "Everyone should wear a cloth face cover or face mask when they have to go out in public.",
                    image: "assets/images/wear_mask.png",
                    title: "Wear Face Mask",
                  ),
                  PreventCard(
                    text:
                        "Regularly and thoroughly clean your hands with an alcohol-based hand rub or wash them with soap and water.",
                    image: "assets/images/wash_hands.png",
                    title: "Wash Your Hands",
                  ),
                  PreventCard(
                    text:
                        "Maintain at least 1 metre (3 feet) distance between yourself and anyone who is coughing or sneezing.",
                    image: "assets/images/keep_distance.png",
                    title: "Maintain Social Distance",
                  ),
                  PreventCard(
                    text:
                        "Hands touch many surfaces and can pick up viruses. Hands can transfer the virus to your eyes, nose or mouth.",
                    image: "assets/images/avoid_touch.png",
                    title: "Avoid Touching Eyes, Nose",
                  ),
                  PreventCard(
                    text:
                        "Stay at home if you begin to feel unwell, even with mild symptoms such as headache and slight runny nose, until you recover.",
                    image: "assets/images/stay_home.png",
                    title: "Stay At Home",
                  ),
                  PreventCard(
                    text:
                        "Use alcohol-based disinfectants to clean hard surfaces in your home like countertops, door handles, furniture, and toys.",
                    image: "assets/images/sanitize.png",
                    title: "Clean And Disinfect",
                  ),
                  SizedBox(height: 32),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;

  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        height: 160.0,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2.0),
                    blurRadius: 8.0,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Image.asset(
              image,
              height: 140.0,
            ),
            Positioned(
              left: 152.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                height: 150.0,
                width: MediaQuery.of(context).size.width - 172.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextStyle.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SvgPicture.asset("assets/icons/forward.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;

  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 2.0),
                  blurRadius: 8.0,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: Offset(0, 2.0),
                  blurRadius: 8.0,
                  color: kShadowColor,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image, height: 88.0),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
