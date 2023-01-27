import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PasswordForgotten extends StatefulWidget {
  PasswordForgotten({Key key,}) : super(key: key);


  @override
  _PasswordForgottenState createState() => _PasswordForgottenState();
}

class _PasswordForgottenState extends State<PasswordForgotten> {
  var username = TextEditingController();
  var password = TextEditingController();

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
              new Padding(padding: new EdgeInsets.all(30.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 300,
                height: 90,
                child: new RaisedButton(
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Send request for password',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 25),),
                  onPressed: null,
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