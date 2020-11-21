import 'package:flutter/material.dart';
import 'package:demo/pages/home.dart';
import 'package:demo/pages/login.dart';
import 'package:demo/pages/loading.dart';
import 'package:demo/pages/registration.dart';
import 'package:demo/pages/personalInfo.dart';
import 'package:demo/pages/restaurantInfo.dart';
import 'package:demo/pages/custHomepage.dart';
import 'package:demo/pages/restHomepage.dart';
import 'package:demo/pages/custMenupage.dart';
import 'package:demo/pages/custRestaurantpage.dart';
import 'package:demo/pages/restMenupage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/loading': (context) => Loading(),
      '/home': (context) => Home(),
      '/registration': (context) => Register(),
      '/personalInfo': (context) => PersonalInfo(),
      '/restaurantPersonalInfo': (context) => RestaurantPersonalInfo(),
      '/customerHomePage': (context) => CustomerHomePage(),
      '/restaurantHomePage': (context) => RestaurantHomePage(),
      '/customerMenuPage': (context) => CustomerMenuPage(),
      '/customerRestaurantPage': (context) => CustomerRestaurantPage(),
      '/restaurantMenuPage': (context) => RestaurantMenuPage(),
    },
  ));
}
