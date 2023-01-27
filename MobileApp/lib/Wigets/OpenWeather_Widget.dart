import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Openweather_Widget extends StatefulWidget {
  Openweather_Widget({Key key}) : super(key: key);

  @override
  _OpenweatherWidgetState createState() => _OpenweatherWidgetState();
}

class _OpenweatherWidgetState extends State<Openweather_Widget> {
  var city = TextEditingController();
  String temp_value = "..";
  String desc_value = "waiting...";

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            decoration: ShapeDecoration(
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 6, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),),
            width: 300,
            height: 60,
            child: TextField(
              maxLines: null,
              controller: city,
              keyboardType: TextInputType.multiline,
              style: new TextStyle(color: Colors.white, fontSize: 22,),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 6.0),
                  ),
                  hintText: 'City'
              ),
            ),
          ),
          new Padding(padding: new EdgeInsets.all(5.0)),
          new Text(temp_value + " °C", textAlign: TextAlign.center, style: new TextStyle(color: Colors.blueGrey, fontSize: 30)),
          new Padding(padding: new EdgeInsets.all(5.0)),
          new Text(desc_value, textAlign: TextAlign.center, style: new TextStyle(color: Colors.blueGrey, fontSize: 30)),
          new Padding(padding: new EdgeInsets.all(5.0)),
          new RaisedButton(
              color: Colors.deepPurple,
              shape: RoundedRectangleBorder(side: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)),
              child: new Text('Update City',
                textAlign: TextAlign.center,
                style: new TextStyle(color: Colors.white, fontSize: 30),),
              onPressed: () async {
                String res = await get_meteo(city.text);
                setState(() {
                  int start = res.indexOf("temp") + 6;
                  int end = res.indexOf("desc") - 3;
                  temp_value = res.substring(start, end);
                  start = res.indexOf("desc") + 7;
                  end = res.indexOf("message") - 4;
                  desc_value = res.substring(start, end);
                });
              },
          ),
        ]
    );
  }
}

String url = 'http://10.0.2.2:8080/api/get_weather';

Future<String>get_meteo(String city) async
{
  Map<String, dynamic> valuejson = {
    "city": city,
  };
  var valuetosend = json.encode(valuejson);
  http.Response res = await http.post(url, body: valuetosend,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },);
  if (res.statusCode == 200) {
    return (res.body);
  } else {
    return ("");
  }
}