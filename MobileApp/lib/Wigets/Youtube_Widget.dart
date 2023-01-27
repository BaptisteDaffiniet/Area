import 'package:flutter/material.dart';

Widget Youtube_Widget(bool search_video_statu){
  if (search_video_statu == true) {
    return(
        new Container (
          width: 300,
          height: 40,
          child:Text('Map_statu == true',
            textAlign: TextAlign.center,
            style: new TextStyle(color: Colors.deepPurple[600], fontSize: 25),
          ),
        )
    );
  }
  else {
    return(
        new Container (
          width: 300,
          height: 40,
          child:Text('',
            textAlign: TextAlign.center,
            style: new TextStyle(color: Colors.deepPurple[600], fontSize: 25),
          ),
        )
    );
  }
}