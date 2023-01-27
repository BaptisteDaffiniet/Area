import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Wigets/Google_Widget.dart';
import '../Wigets/No_Widget.dart';

class GoogleMap extends StatefulWidget {
  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: FutureBuilder<bool>(
        future: get_google_subscriptions(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } if (snapshot.data == false){
            return Scaffold(
              backgroundColor: Colors.lightBlue[100],
              body: SingleChildScrollView(
                child: Container(color: Colors.lightBlue[100],
                  height: 500,
                  width: 400,
                  child: new Center(
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          No_Widget("Google")
                        ]
                    ),
                  ),
                ),
              ),
            );
          } else {
            return new Scaffold(
              backgroundColor: Colors.lightBlue[100],
              body: SingleChildScrollView(
                child: Container(color: Colors.lightBlue[100],
                  child: new Center(
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Google_Map_Widget(true),
                          Gmail_Widget(false),
                        ]
                    ),
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

String google_url = 'http://10.0.2.2:8080/api/is_user_registered_google';

Future<bool>get_google_subscriptions() async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('user_uid');
  Map<String, dynamic> valuejson = {"uid": uid,};
  var valuetosend = json.encode(valuejson);

  http.Response res = await http.post(google_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
  if (res.statusCode == 200)
    return (res.body.toString().contains("true")); //google statu
  else
    return (false);
}