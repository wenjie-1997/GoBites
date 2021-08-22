import 'package:flutter/material.dart';
import 'package:gobites/screens/customer_home/customer_home.dart';
import 'package:gobites/screens/register/register.dart';
import 'package:gobites/screens/register/register_customer.dart';
import 'package:gobites/screens/register/register_restaurant.dart';
import 'package:gobites/screens/restaurant_main/restaurant_main.dart';

import '../screens/login/login.dart';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {
    case '/':
    case '/login':
      return Login.route();
    case '/register':
      return Register.route();
    case '/register_cust':
      return CustRegister.route();
    case '/register_rest':
      return RestRegister.route();
    case '/cust_home':
      return CustomerHome.route();
    case '/rest_main':
      return RestaurantMain.route();
  }
  return null;
}
