import 'package:flutter/material.dart';
import 'package:demo/pages/home.dart';
import 'package:demo/pages/login.dart';
import 'package:demo/pages/loading.dart';
import 'package:demo/pages/registration.dart';
import 'package:demo/pages/customer/personalInfo.dart';
import 'package:demo/pages/restaurant/restaurantInfo.dart';
import 'package:demo/pages/customer/custHomepage.dart';
import 'package:demo/pages/restaurant/restHomepage.dart';
import 'package:demo/pages/customer/custMenupage.dart';
import 'package:demo/pages/customer/custRestaurantpage.dart';
import 'package:demo/pages/restaurant/restMenupage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/loading': (context) => Loading(),
      '/home': (context) => Home(),
      '/registration': (context) => Register(),
      '/personalInfo': (context) => PersonalInfoPage(),
      '/restaurantPersonalInfo': (context) => RestaurantPersonalInfoPage(),
      '/customerHomePage': (context) => CustomerHomePage(),
      '/restaurantHomePage': (context) => RestaurantHomePage(),
      '/customerMenuPage': (context) => CustMenuPage(
            rest: null,
          ),
      '/customerRestaurantPage': (context) => CustRestaurantPage(),
      '/restaurantMenuPage': (context) => RestMenuPage(),
    },
  ));
}
