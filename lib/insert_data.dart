import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19counter/constant.dart';
import 'package:covid19counter/widgets/my_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InsertData extends StatefulWidget {
  final String text;

  const InsertData({Key key, @required this.text}) : super(key: key);

  @override
  _InsertDataState createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  var selectedCountry;
  String totalCase;
  String deathCase;
  String curedCase;

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyHeader(
                  image: "assets/icons/doctor1.svg",
                  textTop: "Insert Corona",
                  textBottom: "Cases Data",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: <Widget>[
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                widget.text.toString().toUpperCase(),
                                style: kTitleTextStyle2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: <Widget>[
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: "Total Cases",
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      labelStyle: kTitleTextStyle3,
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: _controller1,
                                    onChanged: (value) {
                                      this.totalCase = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        labelText: "Death Cases",
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        labelStyle: kTitleTextStyle3),
                                    keyboardType: TextInputType.number,
                                    controller: _controller2,
                                    onChanged: (value) {
                                      this.deathCase = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        labelText: "Cured Cases",
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        labelStyle: kTitleTextStyle3),
                                    keyboardType: TextInputType.number,
                                    controller: _controller3,
                                    onChanged: (value) {
                                      this.curedCase = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  ButtonTheme(
                                    minWidth: double.infinity,
                                    height: 48.0,
                                    child: RaisedButton(
                                      onPressed: () {
                                        selectedCountry = widget.text;
                                        if (selectedCountry == "Global") {
                                          Firestore.instance
                                              .collection('covid_data')
                                              .document('global')
                                              .setData({
                                            'totalCase': this.totalCase,
                                            'deathCase': this.deathCase,
                                            'curedCase': this.curedCase,
                                          }).then((results) {
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                              "Data Inserted",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )));
                                          }).catchError((e) {
                                            _controller1.clear();
                                            _controller2.clear();
                                            _controller3.clear();
                                            print(e.toString());
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                              e.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )));
                                          });
                                        } else {
                                          Firestore.instance
                                              .collection('covid_data')
                                              .document('india')
                                              .setData({
                                            'totalCase': this.totalCase,
                                            'deathCase': this.deathCase,
                                            'curedCase': this.curedCase,
                                          }).then((results) {
                                            _controller1.clear();
                                            _controller2.clear();
                                            _controller3.clear();
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                              "Data Inserted",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )));
                                          }).catchError((e) {
                                            print(e.toString());
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                              e.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )));
                                          });
                                        }
                                      },
                                      child: Text(
                                        "CONTINUE",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.0,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
