import 'package:flutter/material.dart';
import 'package:demo/pages/home.dart';
import 'package:demo/pages/login.dart';
import 'package:demo/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/loading',
    routes: {
      '/': (context) => Login(),
      '/loading': (context) => Loading(),
      '/home': (context) => Home(),
    },
  ));
}
