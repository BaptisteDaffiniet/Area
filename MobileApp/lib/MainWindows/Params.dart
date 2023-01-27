import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../LoginPages/LoginPage.dart';
import 'package:flutter_app/MenuMultiPage.dart';

class Params extends StatefulWidget {
  @override
  _ParamsState createState() => _ParamsState();
}

class _ParamsState extends State<Params> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.lightBlue[100],
        body: FutureBuilder<List<bool>>(
          future: get_subscriptions(),
          builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
            if (snapshot.hasData == false) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Container(color: Colors.lightBlue[100],
                  child: new Center(
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Google Services',
                                textAlign: TextAlign.center,
                                style: new TextStyle(color: Colors.deepPurple[600], fontSize: 22),
                              ),
                              new Padding(padding: new EdgeInsets.all(5.0)),
                              new Icon(FontAwesomeIcons.google, color: Colors.deepPurple[600],),
                              new Padding(padding: new EdgeInsets.all(5.0)),
                              new Switch(
                                value: snapshot.data[0],
                                onChanged: (value) async {
                                  print(value);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  String uid = prefs.getString('user_uid');
                                  Map<String, dynamic> valuejson = {"uid": uid,};
                                  var valuetosend = json.encode(valuejson);
                                  if (value == false) {
                                    String unregistrer_url = 'http://10.0.2.2:8080/api/unregister_google';
                                    http.Response res = await http.post(unregistrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  } else {
                                    String registrer_url = 'http://10.0.2.2:8080/api/register_google';
                                    http.Response res = await http.post(registrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  }
                                  setState(() {
                                    print(value);
                                    snapshot.data[0] = value;
                                    print(value);
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Twitter',
                                textAlign: TextAlign.center,
                                style: new TextStyle(color: Colors.deepPurple[600], fontSize: 22),
                              ),
                              new Padding(padding: new EdgeInsets.all(5.0)),
                              new Icon(FontAwesomeIcons.twitter, color: Colors.deepPurple[600],),
                              new Padding(padding: new EdgeInsets.all(4.0)),
                              Switch(
                                value: snapshot.data[1],
                                onChanged: (value) async {
                                  print(value);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  String uid = prefs.getString('user_uid');
                                  Map<String, dynamic> valuejson = {"uid": uid,};
                                  var valuetosend = json.encode(valuejson);
                                  if (value == false) {
                                    String unregistrer_url = 'http://10.0.2.2:8080/api/unregister_twitter';
                                    http.Response res = await http.post(unregistrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  } else {
                                    String registrer_url = 'http://10.0.2.2:8080/api/register_twitter';
                                    http.Response res = await http.post(registrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  }
                                  setState(() {
                                    print(value);
                                    snapshot.data[1] = value;
                                    print(value);
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Youtube',
                                textAlign: TextAlign.center,
                                style: new TextStyle(color: Colors.deepPurple[600], fontSize: 22),
                              ),
                              new Padding(padding: new EdgeInsets.all(5.0)),
                              new Icon(FontAwesomeIcons.youtube, color: Colors.deepPurple[600],),
                              new Padding(padding: new EdgeInsets.all(4.0)),
                              Switch(
                                value: snapshot.data[2],
                                onChanged: (value) async {
                                  print(value);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  String uid = prefs.getString('user_uid');
                                  Map<String, dynamic> valuejson = {"uid": uid,};
                                  var valuetosend = json.encode(valuejson);
                                  if (value == false) {
                                    String unregistrer_url = 'http://10.0.2.2:8080/api/unregister_youtube';
                                    http.Response res = await http.post(unregistrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  } else {
                                    String registrer_url = 'http://10.0.2.2:8080/api/register_youtube';
                                    http.Response res = await http.post(registrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  }
                                  setState(() {
                                    print(value);
                                    snapshot.data[2] = value;
                                    print(value);
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Instagram',
                                textAlign: TextAlign.center,
                                style: new TextStyle(color: Colors.deepPurple[600], fontSize: 22),
                              ),
                              new Padding(padding: new EdgeInsets.all(5.0)),
                              new Icon(FontAwesomeIcons.instagram, color: Colors.deepPurple[600],),
                              new Padding(padding: new EdgeInsets.all(4.0)),
                              Switch(
                                value: snapshot.data[3],
                                onChanged: (value) async {
                                  print(value);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  String uid = prefs.getString('user_uid');
                                  Map<String, dynamic> valuejson = {"uid": uid,};
                                  var valuetosend = json.encode(valuejson);
                                  if (value == false) {
                                    String unregistrer_url = 'http://10.0.2.2:8080/api/unregister_instagram';
                                    http.Response res = await http.post(unregistrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  } else {
                                    String registrer_url = 'http://10.0.2.2:8080/api/register_instagram';
                                    http.Response res = await http.post(registrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  }
                                  setState(() {
                                    print(value);
                                    snapshot.data[3] = value;
                                    print(value);
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('OpenWeather',
                                textAlign: TextAlign.center,
                                style: new TextStyle(color: Colors.deepPurple[600], fontSize: 22),
                              ),
                              new Padding(padding: new EdgeInsets.all(5.0)),
                              new Icon(Icons.filter_drama, color: Colors.deepPurple[600],),
                              new Padding(padding: new EdgeInsets.all(4.0)),
                              Switch(
                                value: snapshot.data[4],
                                onChanged: (value) async {
                                  print(value);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  String uid = prefs.getString('user_uid');
                                  Map<String, dynamic> valuejson = {"uid": uid,};
                                  var valuetosend = json.encode(valuejson);
                                  if (value == false) {
                                    String unregistrer_url = 'http://10.0.2.2:8080/api/unregister_openweather';
                                    http.Response res = await http.post(unregistrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  } else {
                                    String registrer_url = 'http://10.0.2.2:8080/api/register_openweather';
                                    http.Response res = await http.post(registrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  }
                                  setState(() {
                                    print(value);
                                    snapshot.data[4] = value;
                                    print(value);
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Money Change',
                                textAlign: TextAlign.center,
                                style: new TextStyle(color: Colors.deepPurple[600], fontSize: 22),
                              ),
                              new Padding(padding: new EdgeInsets.all(5.0)),
                              new Icon(FontAwesomeIcons.dollarSign, color: Colors.deepPurple[600],),
                              new Padding(padding: new EdgeInsets.all(4.0)),
                              Switch(
                                value: snapshot.data[5],
                                onChanged: (value) async {
                                  print(value);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  String uid = prefs.getString('user_uid');
                                  Map<String, dynamic> valuejson = {"uid": uid,};
                                  var valuetosend = json.encode(valuejson);
                                  if (value == false) {
                                    String unregistrer_url = 'http://10.0.2.2:8080/api/unregister_conversion';
                                    http.Response res = await http.post(unregistrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  } else {
                                    String registrer_url = 'http://10.0.2.2:8080/api/register_conversion';
                                    http.Response res = await http.post(registrer_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
                                    print (res.statusCode);
                                  }
                                  setState(() {
                                    print(value);
                                    snapshot.data[5] = value;
                                    print(value);
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                          new Padding(padding: new EdgeInsets.all(15.0)),
                          new Container(
                            padding: EdgeInsets.only(top: 24),
                            width: 250,
                            height: 60,
                            child: new RaisedButton(
                                color: Colors.deepPurple,
                                shape: RoundedRectangleBorder(side: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15)),
                                child: new Text('Disconnect',
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(color: Colors.white, fontSize: 30),),
                                onPressed: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('user_connected', false);
                                  prefs.setString('user_token', null);
                                  prefs.setString('user_uid', null);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Disconnection"),
                                          content: Text("You are disconnected"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Close"),
                                              onPressed: () {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => LoginPage()
                                                    ),
                                                    ModalRoute.withName("/Home")
                                                );
                                              },
                                            )
                                          ],
                                        );
                                      }
                                  );
                                }
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              );
            }
          },
        ),
      );
  }
}
