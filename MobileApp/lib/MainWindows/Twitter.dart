import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Wigets/Twitter_Widget.dart';
import '../Wigets/No_Widget.dart';

class Twitter extends StatefulWidget {
  @override
  _TwitterState createState() => _TwitterState();
}

class _TwitterState extends State<Twitter> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: FutureBuilder<bool>(
        future: get_twitter_subscriptions(),
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
                          No_Widget("Twitter")
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
                  height: 450,
                  width: 400,
                  child: new Center(
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Twitter_Post_Widget(),
                          new Padding(padding: new EdgeInsets.all(25.0)),
                          Twitter_Post_Search_Widget(),
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

String google_url = 'http://10.0.2.2:8080/api/is_user_registered_twitter';

Future<bool>get_twitter_subscriptions() async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('user_uid');
  Map<String, dynamic> valuejson = {"uid": uid,};
  var valuetosend = json.encode(valuejson);

  http.Response res = await http.post(google_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
  if (res.statusCode == 200)
    return (res.body.toString().contains("true")); //twitter statu
  else
    return (false);
}