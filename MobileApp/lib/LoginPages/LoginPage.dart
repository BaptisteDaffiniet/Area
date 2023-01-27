import 'dart:io';
import 'CreateAnAccount.dart';
import 'PasswordForgotten.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../MenuMultiPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var username = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getconnectionstatu(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == false) {
          return Scaffold(
            backgroundColor: Colors.lightBlue[100],
            appBar: AppBar(
                leading: new IconButton(icon: new Icon(Icons.home), onPressed: () {},),
                title: Text("Welcome")),
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
                            hintText: 'User Email'
                        ),
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(15.0)),
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
                      padding: EdgeInsets.only(top: 24),
                      width: 250,
                      height: 60,
                      child: new RaisedButton(
                          color: Colors.deepPurple,
                          shape: RoundedRectangleBorder(side: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          child: new Text('Connection',
                            textAlign: TextAlign.center,
                            style: new TextStyle(color: Colors.white, fontSize: 30),),
                          onPressed: () async {
                            int acces_return = await Connect_Account_Normal(password.text, username.text);
                            if (acces_return == 223) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHome()
                                  ),
                                  ModalRoute.withName("/Home")
                              );
                            }
                            else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text("Check Password or Email"),
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
                    new Padding(padding: new EdgeInsets.all(30.0)),
                    new Container(
                      padding: EdgeInsets.only(top: 24),
                      width: 250,
                      height: 50,
                      child: new RaisedButton(
                          color: Colors.deepPurple,
                          shape: RoundedRectangleBorder(side: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          child: new Text('Create an account',
                            textAlign: TextAlign.center,
                            style: new TextStyle(color: Colors.white, fontSize: 20),),
                          onPressed: () {
                            var route = new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new CreateAnAccount(),);
                            Navigator.of(context).push(route);
                          }
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(5.0)),
                    new Container(
                      padding: EdgeInsets.only(top: 24),
                      width: 250,
                      height: 50,
                      child: new RaisedButton(
                          color: Colors.deepPurple,
                          shape: RoundedRectangleBorder(side: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          child: new Text('Password forgotten',
                            textAlign: TextAlign.center,
                            style: new TextStyle(color: Colors.white, fontSize: 20),),
                          onPressed: () {
                            var route = new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new PasswordForgotten(),);
                            Navigator.of(context).push(route);
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return MyHome();
        }
      },
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

Future<bool> getconnectionstatu () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool value = prefs.getBool('user_connected');
  if (value == null) {
    value = false;
    prefs.setBool('user_connected', value);
  }
  return (value);
}

String url = 'http://10.0.2.2:8080/api/connection';

Future<int> Connect_Account_Normal(String password, String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> valuejson = {
    "email": email,
    "password": password,
    "token_sended": '',
  };
  var valuetosend = json.encode(valuejson);
  print(valuetosend);
  http.Response res = await http.post(url, body: valuetosend,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },);
  if (res.statusCode == 223) {
    prefs.setBool('user_connected', true);
    print(res.body);
    //Get and set uid and token
    String body = res.body.toString();
    int end = body.indexOf('email') - 3;
    int start = 16;
    String uid = body.substring(start, end);
    prefs.setString('user_uid', uid);
    end = body.indexOf('roles') - 3;
    start = body.indexOf('token') + 7;
    String token = body.substring(start, end);
    prefs.setString('user_token', token);
    print('user connected');
  }
  return (res.statusCode);
}