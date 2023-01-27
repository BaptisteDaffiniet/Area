import 'package:flutter/material.dart';

Widget Google_Map_Widget(bool map_statu){
  if (map_statu == true) {
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

Widget Gmail_Widget(bool city_map_statu){
  if (city_map_statu == true) {
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