import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19counter/case_details.dart';
import 'package:covid19counter/constant.dart';
import 'package:covid19counter/info_screen.dart';
import 'package:covid19counter/insert_data.dart';
import 'package:covid19counter/widgets/counter.dart';
import 'package:covid19counter/widgets/my_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

String _total = "0";
String _deaths = "0";
String _cured = "0";

class MyApp extends StatelessWidget {
  final SystemUiOverlayStyle systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid 19',
        theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            fontFamily: "Poppins",
            textTheme: TextTheme(
              body1: TextStyle(color: kBodyTextColor),
            )),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _country = <String>['India', 'Global'];
  var selectedCountry = 'India';

  QuerySnapshot covidData;

  get snap => null;

  @override
  void initState() {
    Firestore.instance.collection('covid_data').getDocuments().then((results) {
      setState(() {
        covidData = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/doctor2.svg",
              textTop: "All you need is",
              textBottom: "to stay at Home",
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
              height: 60.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                      items: _country
                          .map((value) => DropdownMenuItem(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: kBodyTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (selectedRegion) {
                        setState(() {
                          selectedCountry = selectedRegion;
                        });
                      },
                      value: selectedCountry,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Case Update\n",
                              style: kTitleTextStyle,
                            ),
                            TextSpan(
                              text: "Updating Every 4 Hours ",
                              style: TextStyle(
                                color: kTextLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CaseDetails(text: selectedCountry)));
                        },
                        child: Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  InsertData(text: selectedCountry)));*/
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 32.0, horizontal: 16.0),
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
                      child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection("covid_data")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: const CupertinoActivityIndicator(),
                              );
                            } else {
                              if (selectedCountry == "Global") {
                                final DocumentSnapshot snap =
                                    snapshot.data.documents[0];
                                _total = snap["totalCase"].toString();
                                _deaths = snap["deathCase"].toString();
                                _cured = snap["curedCase"].toString();
                              } else {
                                final DocumentSnapshot snap =
                                    snapshot.data.documents[1];
                                _total = snap["totalCase"].toString();
                                _deaths = snap["deathCase"].toString();
                                _cured = snap["curedCase"].toString();
                              }

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Counter(
                                    color: kInfectedColor,
                                    number: int.parse(_total),
                                    title: "Infected",
                                  ),
                                  Counter(
                                    color: kDeathColor,
                                    number: int.parse(_deaths),
                                    title: "Deaths",
                                  ),
                                  Counter(
                                    color: kRecoverColor,
                                    number: int.parse(_cured),
                                    title: "Recovered",
                                  ),
                                ],
                              );
                            }
                          }),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Spread of Virus",
                        style: kTitleTextStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      InfoScreen()));
                        },
                        child: Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                    child: Image.asset(
                      "assets/images/map.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Support and Helplines",
                        style: kTitleTextStyle,
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 32.0),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Helpline Number :",
                            style: kBodyTextStyle,
                          ),
                          Text(
                            "011-23978046",
                            style: kTitleTextStyle3,
                          ),
                          Text(
                            "1075 (Toll Free)",
                            style: kTitleTextStyle3,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "Email :",
                            style: kBodyTextStyle,
                          ),
                          Text(
                            'ncov2019@gov.in',
                            style: kTitleTextStyle3,
                          ),
                        ],
                      )),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "MyGov Live HelpDesk",
                        style: kTitleTextStyle,
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
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
                      child: GestureDetector(
                        child: Container(
                          child: Image.asset(
                            "assets/images/helpdesk.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        onTap: () async {
                          if (await canLaunch("https://wa.me/919013151515")) {
                            await launch("https://wa.me/919013151515");
                          }
                        },
                      )),
                  Container(
                    height: 32.0,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
