import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19counter/constant.dart';
import 'package:covid19counter/widgets/closed_counter.dart';
import 'package:covid19counter/widgets/detail_counter.dart';
import 'package:covid19counter/widgets/my_header.dart';
import 'package:covid19counter/widgets/percent_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String _total = "0";
String _deaths = "0";
String _cured = "0";

int total;
int deaths;
int cured;

class CaseDetails extends StatefulWidget {
  final String text;

  const CaseDetails({Key key, @required this.text}) : super(key: key);

  @override
  _CaseDetailsState createState() => _CaseDetailsState();
}

class _CaseDetailsState extends State<CaseDetails> {
  var selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          MyHeader(
            image: "assets/icons/doctor1.svg",
            textTop: "Corona Cases",
            textBottom: "        Details",
          ),
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
                            text: "Case Details\n",
                            style: kTitleTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 16.0),
                Container(
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
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("covid_data")
                          .snapshots(),
                      builder: (context, snapshot) {
                        selectedCountry = widget.text;
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

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: kBodyLightColor,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 2.0),
                                      blurRadius: 8.0,
                                      color: kShadowColor,
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 60.0,
                                child: Text(
                                  selectedCountry.toString().toUpperCase(),
                                  style: kTitleTextStyle2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                              Column(
                                children: <Widget>[
                                  DetailCounter(
                                    title: "Coronavirus Cases:",
                                    number: int.parse(_total),
                                    color: kInfectedColor,
                                  ),
                                  SizedBox(
                                    height: 32.0,
                                  ),
                                  DetailCounter(
                                    title: "Deaths:",
                                    number: int.parse(_deaths),
                                    color: kDeathColor,
                                  ),
                                  SizedBox(
                                    height: 32.0,
                                  ),
                                  DetailCounter(
                                    title: "Recovered:",
                                    number: int.parse(_cured),
                                    color: kRecoverColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16.0,
                              )
                            ],
                          );
                        }
                      }),
                ),
                SizedBox(height: 32.0),
                Container(
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
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("covid_data")
                          .snapshots(),
                      builder: (context, snapshot) {
                        selectedCountry = widget.text;
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

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: kBodyLightColor,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 2.0),
                                      blurRadius: 8.0,
                                      color: kShadowColor,
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 60.0,
                                child: Text(
                                  "CLOSED CASES",
                                  style: kTitleTextStyle4,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 32.0,
                              ),
                              Container(
                                child: ClosedCounter(
                                  number:
                                      (int.parse(_deaths) + int.parse(_cured)),
                                  title: "Cases which had an outcome",
                                  color: kOutcomeColor,
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        ClosedCounter(
                                          number: int.parse(_cured),
                                          title: "Recoverd",
                                          color: kRecoverColor,
                                        ),
                                        PercentCounter(
                                          number: ((int.parse(_cured) * 100) /
                                                  (int.parse(_deaths) +
                                                      int.parse(_cured)))
                                              .round(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        ClosedCounter(
                                          number: int.parse(_deaths),
                                          title: "Deaths",
                                          color: kDeathColor,
                                        ),
                                        PercentCounter(
                                          number: ((int.parse(_deaths) * 100) /
                                                  (int.parse(_deaths) +
                                                      int.parse(_cured)))
                                              .round(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 32.0,
                              )
                            ],
                          );
                        }
                      }),
                ),
                Container(
                  height: 32.0,
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
