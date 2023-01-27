import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Twitter_Post_Widget extends StatefulWidget {
  Twitter_Post_Widget({Key key}) : super(key: key);

  @override
  _Twitter_Post_WidgetState createState() => _Twitter_Post_WidgetState();
}

class _Twitter_Post_WidgetState extends State<Twitter_Post_Widget> {
  var tweet = TextEditingController();

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
            width: 400,
            height: 100,
            child: TextField(
              maxLength: 257,
              maxLines: null,
              controller: tweet,
              keyboardType: TextInputType.multiline,
              style: new TextStyle(color: Colors.white, fontSize: 22,),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 6.0),
                  ),
                  hintText: 'Write Here'
              ),
            ),
          ),
          new Padding(padding: new EdgeInsets.all(5.0)),
          new RaisedButton(
            color: Colors.deepPurple,
            shape: RoundedRectangleBorder(side: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            child: new Text('Send Tweet',
              textAlign: TextAlign.center,
              style: new TextStyle(color: Colors.white, fontSize: 30),),
            onPressed: () async {
              int res = await send_tweet(tweet.text);
              if (res == 200) {
                tweet.clear();
                return AlertDialog(
                  title: Text("Result"),
                  content: Text("Tweet Sended"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              }
            },
          ),
        ]
    );
  }
}

String url = 'http://10.0.2.2:8080/api/send_tweet';

Future<int>send_tweet(String tweet) async
{
  Map<String, dynamic> valuejson = {
    "statuses": tweet,
  };
  var valuetosend = json.encode(valuejson);
  http.Response res = await http.post(url, body: valuetosend,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },);
  return (res.statusCode);
}

class Statuses {
  final String statuses;

  Statuses({this.statuses});

  factory Statuses.fromJson(Map<String, dynamic> json) {
    return Statuses(
      statuses: json['statuses'] as String,
    );
  }
}

class Twitter_Post_Search_Widget extends StatefulWidget {
  @override
  Twitter_Post_Search_WidgetState createState() => new Twitter_Post_Search_WidgetState();
}

class Twitter_Post_Search_WidgetState extends State<Twitter_Post_Search_Widget> {

  @override
  Widget build(BuildContext context) {
    return Container (
      height: 200,
      width: 400,
      child: FutureBuilder<List<String>>(
        future: get_tweet(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("Tweet number " + (index + 1).toString()),
                  subtitle: Text(snapshot.data[index]),
                  onTap: null
                );
              },
            );
          }
        },
      ),
    );
  }
}


String get_tweet_url = 'http://10.0.2.2:8080/api/get_last_user_tweet';

Future<List<String>>get_tweet() async
{
  List<String> list = List(10);
  Map<String, dynamic> valuejson = {
    "username": "Epitech",
  };
  var valuetosend = json.encode(valuejson);
  http.Response res = await http.post(get_tweet_url, body: valuetosend,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },);
  print(res.body);
  int start = res.body.indexOf("statuses") + 12;
  int end = res.body.indexOf('","');
  list[0] = res.body.substring(start, end);
  print(list[0]);
  for (int i = 1; i <= 8; i++) {
    start = end + 3;
    end = res.body.indexOf('","', end + 1);
    list[i] = res.body.substring(start, end);
  }
  start = end;
  end = res.body.indexOf("message") - 5;
  list[9] = res.body.substring(start, end);
  return (list);
}