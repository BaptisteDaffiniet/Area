import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'MainWindows/GoogleMap.dart';
import 'MainWindows/Twitter.dart';
import 'MainWindows/Youtube.dart';
import 'MainWindows/Instagram.dart';
import 'MainWindows/Tools.dart';
import 'MainWindows/Params.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

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
            return DefaultTabController(length: 6, child: Scaffold(
              appBar: AppBar(
                leading: IconButton(icon: new Icon(Icons.home), onPressed: () {}),
                title: Text('Home', style: TextStyle(color: Colors.white),),
                flexibleSpace: Container(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          const Color(0xFF673AB7),
                          const Color(0xFF3F51B5),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.8, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ),
                bottom: TabBar(
                    labelStyle: TextStyle(fontSize: 16),
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black12,
                    ),
                    tabs: [
                      Tab(icon: new Icon(FontAwesomeIcons.google),),
                      Tab(icon: new Icon(FontAwesomeIcons.twitter),),
                      Tab(icon: new Icon(FontAwesomeIcons.youtube),),
                      Tab(icon: new Icon(FontAwesomeIcons.instagram),),
                      Tab(icon: new Icon(Icons.build),),
                      Tab(icon: new Icon(Icons.person),),
                    ]
                ),
              ),
              body: TabBarView(children: [
                GoogleMap(),
                Twitter(),
                Youtube(),
                Instagram(),
                Tools(),
                Params(),
              ]),
            )
            );
          }
        },
      ),
    );
  }
}

String google_url = 'http://10.0.2.2:8080/api/is_user_registered_google';
String twitter_url = 'http://10.0.2.2:8080/api/is_user_registered_twitter';
String youtube_url = 'http://10.0.2.2:8080/api/is_user_registered_youtube';
String instagram_url = 'http://10.0.2.2:8080/api/is_user_registered_instagram';
String open_weather_url = 'http://10.0.2.2:8080/api/is_user_registered_openweather';
String money_change_url = 'http://10.0.2.2:8080/api/is_user_registered_conversion';

Future<List<bool>>get_subscriptions() async
{
  List<bool> statu_list = List.generate(6, (index) => false);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('user_uid');
  Map<String, dynamic> valuejson = {"uid": uid,};
  var valuetosend = json.encode(valuejson);

  http.Response res = await http.post(google_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
  if (res.statusCode == 200)
    statu_list[0] = res.body.toString().contains("true"); //google statu
  res = await http.post(twitter_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
  if (res.statusCode == 200)
    statu_list[1] = res.body.toString().contains("true"); //twitter statu
  res = await http.post(youtube_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
  if (res.statusCode == 200)
    statu_list[2] = res.body.toString().contains("true"); //youtube statu
  res = await http.post(instagram_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
  if (res.statusCode == 200)
    statu_list[3] = res.body.toString().contains("true"); //instagram statu
  res = await http.post(open_weather_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
  if (res.statusCode == 200)
    statu_list[4] = res.body.toString().contains("true"); //open weather statu
  res = await http.post(money_change_url, body: valuetosend, headers: {HttpHeaders.contentTypeHeader: 'application/json',},);
  if (res.statusCode == 200)
    statu_list[5] = res.body.toString().contains("true"); //money change statu
  return (statu_list);
}
