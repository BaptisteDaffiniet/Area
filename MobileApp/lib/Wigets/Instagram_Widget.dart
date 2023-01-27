import 'package:flutter/material.dart';

Widget Instagram_Widget(bool search_post_statu){
  if (search_post_statu == true) {
    return(
        new Container (
          width: 300,
          height: 40,
          child:Text('search_post_statu == true',
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