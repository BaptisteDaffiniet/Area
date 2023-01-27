import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateAnAccount extends StatefulWidget {
  CreateAnAccount({Key key,}) : super(key: key);

  @override
  _CreateAnAccountState createState() => _CreateAnAccountState();
}

class _CreateAnAccountState extends State<CreateAnAccount> {
  var username = TextEditingController();
  var password = TextEditingController();
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
          leading: new IconButton(icon: new Icon(Icons.account_box), onPressed: () {},),
          title: Text("Create and account")),
      body:
      CustomPaint(
        painter: CurvePainter(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                  controller: username,
                  keyboardType: TextInputType.multiline,
                  style: new TextStyle(color: Colors.white, fontSize: 22,),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Username'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
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
                  controller: password,
                  keyboardType: TextInputType.multiline,
                  style: new TextStyle(color: Colors.white, fontSize: 22,),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Password'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
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
                  controller: email,
                  keyboardType: TextInputType.multiline,
                  style: new TextStyle(color: Colors.white, fontSize: 22,),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Email adress'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(30.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 300,
                height: 60,
                child: new RaisedButton(
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Create the account',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 25),),
                  onPressed: () async {
                    int res = await Create_Account(username.text, password.text, email.text);
                    if (res == 201) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Welcome"),
                              content: Text("You should receive an email!"),
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
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text("An error occurred retry"),
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
                      );
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Wave style bottom of the page
class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.deepPurple;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875, size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584, size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

String url = 'http://10.0.2.2:8080/api/create_user';

Future<int> Create_Account(String name, String password, String email) async {
  Map<String, dynamic> valuejson = {
    "email": email,
    "password": password,
    "username": name,
  };
  String valuetosend = json.encode(valuejson);
  print(valuetosend);
  http.Response res = await http.post(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: valuetosend);
  return (res.statusCode);
}