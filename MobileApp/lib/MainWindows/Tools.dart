import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Wigets/OpenWeather_Widget.dart';
import '../Wigets/Money_Change_Widget.dart';
import '../Wigets/No_Widget.dart';

class Tools extends StatefulWidget {

  @override
  _ToolsState createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: FutureBuilder<List<bool>>(
        future: get_status(),
        builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data[0] == false && snapshot.data[1] == false) {
            return SingleChildScrollView(
              child: Container(color: Colors.lightBlue[100],
                height: 450,
                width: 400,
                child: new Center(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        No_Widget("Open Weather"),
                        new Padding(padding: new EdgeInsets.all(25.0)),
                        No_Widget("Money Change")
                      ]
                  ),
                ),
              ),
            );
          }
          if (snapshot.data[0] == true && snapshot.data[1] == true) {
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
                            Openweather_Widget(),
                            new Padding(padding: new EdgeInsets.all(25.0)),
                            MoneyChange_Widget()
                          ]
                      ),
                  ),
                ),
              ),
            );
          }
          if (snapshot.data[0] == true && snapshot.data[1] == false) {
            return SingleChildScrollView(
              child: Container(color: Colors.lightBlue[100],
                height: 450,
                width: 400,
                child: new Center(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Openweather_Widget(),
                        new Padding(padding: new EdgeInsets.all(25.0)),
                        No_Widget("Money Change")
                      ]
                  ),
                ),
              ),
            );
          }
          else {
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
                          No_Widget("Open Weather"),
                          new Padding(padding: new EdgeInsets.all(25.0)),
                          MoneyChange_Widget()
                        ]
                    ),
                  ),
                ),
              ),
            );
          }
        })
    );
  }
}

Future<List<bool>>get_status() async
{
  List<bool> list = List(2);
  list[0] = await get_openweather_subscriptions();
  list[1] = await get_money_subscriptions();
  return (list);
}

String openweather_url = 'http://10.0.2.2:8080/api/is_user_registered_openweather';

Future<bool>get_openweather_subscriptions() async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('user_uid');
  Map<String, dynamic> valuejson = {"uid": uid,};
  var valuetosend = json.encode(valuejson);

  http.Response res = await http.post(openweather_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
  if (res.statusCode == 200)
    return (res.body.toString().contains("true")); //openweather statu
  else
    return (false);
}

String money_url = 'http://10.0.2.2:8080/api/is_user_registered_conversion';

Future<bool>get_money_subscriptions() async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('user_uid');
  Map<String, dynamic> valuejson = {"uid": uid,};
  var valuetosend = json.encode(valuejson);

  http.Response res = await http.post(money_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
  if (res.statusCode == 200)
    return (res.body.toString().contains("true")); //youtube statu
  else
    return (false);
}