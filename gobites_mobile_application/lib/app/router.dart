import 'package:flutter/material.dart';
import 'package:gobites/screens/customer_home/customer_home.dart';
import 'package:gobites/screens/register/register.dart';
import 'package:gobites/screens/restaurant_home/restaurant_home.dart';

import '../screens/login/login.dart';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {
    case '/':
    case '/login':
      return Login.route();
    case '/register':
      return Register.route();
    case '/cust_home':
      return CustomerHome.route();
    case '/rest_home':
      return RestaurantHome.route();
  }
  return null;
}
