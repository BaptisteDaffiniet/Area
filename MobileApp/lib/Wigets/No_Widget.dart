import 'package:flutter/material.dart';

Widget No_Widget(String name)
{
  return Text(name + ':\n\nYou are not subscribed to this service check your parameters.',
    textAlign: TextAlign.center,
    style: new TextStyle(color: Colors.deepPurple[600], fontSize: 25),
  );
}