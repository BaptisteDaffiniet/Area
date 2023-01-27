import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MoneyChange_Widget extends StatefulWidget {
  MoneyChange_Widget({Key key}) : super(key: key);

  @override
  _MoneyChangeWidgetState createState() => _MoneyChangeWidgetState();
}

class _MoneyChangeWidgetState extends State<MoneyChange_Widget> {
  String value = "...";
  String Currency1 = 'EUR';
  String Currency2 = 'USD';

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  decoration: ShapeDecoration(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 6, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),),
                  width: 50,
                  height: 60,
                  child: new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.grey,),
                    child: DropdownButton<String>(
                      iconEnabledColor: Colors.grey,
                      iconDisabledColor: Colors.grey,
                      iconSize: 0,
                      value: Currency1,
                      onChanged: (String newValue) {
                        setState(() {
                          Currency1 = newValue;
                        });
                        },
                      items: <String>["EUR", "BTC","USD",
                        "GBP","HKD", "JPY"]
                          .map<DropdownMenuItem<String>>((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                style: new TextStyle(backgroundColor: Colors.grey,color: Colors.white, fontSize: 19),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
                new Padding(padding: new EdgeInsets.all(10.0)),
                new Text(value, textAlign: TextAlign.center, style: new TextStyle(color: Colors.blueGrey, fontSize: 30)),
                new Padding(padding: new EdgeInsets.all(10.0)),
                new Container(
                  decoration: ShapeDecoration(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 6, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),),
                  width: 50,
                  height: 60,
                  child: new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.grey,),
                    child: DropdownButton<String>(
                      iconEnabledColor: Colors.grey,
                      iconDisabledColor: Colors.grey,
                      iconSize: 0,
                      value: Currency2,
                      onChanged: (String newValue) {
                        setState(() {
                          Currency2 = newValue;
                        });
                      },
                      items: <String>["EUR", "BTC","USD",
                        "GBP","HKD", "JPY"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                            style: new TextStyle(backgroundColor: Colors.grey,color: Colors.white, fontSize: 19),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ]
          ),
          new Padding(padding: new EdgeInsets.all(5.0)),
          new RaisedButton(
            color: Colors.deepPurple,
            shape: RoundedRectangleBorder(side: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            child: new Text('Update City',
              textAlign: TextAlign.center,
              style: new TextStyle(color: Colors.white, fontSize: 30),),
            onPressed: () async {
              String res = await get_currency(Currency1, Currency2);
              setState(() {
                int start = res.indexOf("value") + 8;
                int end = res.indexOf("currency") - 3;
                value = res.substring(start, end);
              });
            },
          ),
        ],
    );
  }
}

String url = 'http://10.0.2.2:8080/api/get_action_currency';

Future<String>get_currency(String currency1, String currency2) async
{
  print("inside function");
  Map<String, dynamic> valuejson = {
    "currency_1": currency1,
    "currency_2": currency2,
  };
  var valuetosend = json.encode(valuejson);
  print(valuetosend);
  http.Response res = await http.post(url, body: valuetosend,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },);
  print(res.body);
  if (res.statusCode == 200) {
    print("results ==");
    print(res.body);
    return (res.body);
  } else {
    return ("...");
  }
}