import 'package:flutter/material.dart';
import 'package:gobites/screens/customer_cart/customer_cart.dart';
import 'package:gobites/screens/customer_edit_profile/customer_edit_profile.dart';
import 'package:gobites/screens/customer_main/customer_main.dart';
import 'package:gobites/screens/customer_restaurant_list/customer_restaurant_list.dart';
import 'package:gobites/screens/customer_restaurant_menu/customer_restaurant_menu.dart';
import 'package:gobites/screens/register/register.dart';
import 'package:gobites/screens/register/register_customer.dart';
import 'package:gobites/screens/register/register_restaurant.dart';
import 'package:gobites/screens/restaurant_add_menu/restaurant_add_menu.dart';
import 'package:gobites/screens/restaurant_edit_menu/restaurant_edit_menu.dart';
import 'package:gobites/screens/restaurant_edit_profile/restaurant_edit_profile.dart';
import 'package:gobites/screens/restaurant_feedback/restaurant_feedback.dart';
import 'package:gobites/screens/restaurant_main/restaurant_main.dart';
import 'package:gobites/screens/restaurant_menu/restaurant_menu.dart';
import 'package:gobites/screens/restaurant_order/restaurant_order.dart';
import 'package:gobites/screens/restaurant_order/restaurant_order_items.dart';

import '../screens/login/login.dart';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {
    case '/login':
      return Login.route();
    case '/register':
      return Register.route();
    case '/register_cust':
      return CustRegister.route();
    case '/register_rest':
      return RestRegister.route();
    case '/rest_main':
      return RestaurantMain.route();
    case '/rest_edit_profile':
      return RestaurantEditProfile.route();
    case '/rest_menu':
      return RestaurantMenu.route();
    case '/rest_add_menu':
      return RestaurantAddMenu.route();
    case '/rest_edit_menu':
      return RestaurantEditMenu.route(settings.arguments);
    case '/rest_order':
      return RestaurantOrder.route();
    case '/rest_order_items':
      return RestaurantOrderItems.route(settings.arguments);
    case '/rest_feedback':
      return RestaurantFeedback.route();
    case '/cust_main':
      return CustomerMain.route();
    case '/cust_edit_profile':
      return CustomerEditProfile.route();
    case '/cust_restaurant_list':
      return CustomerRestaurantList.route();
    case '/cust_restaurant_menu':
      return CustomerRestaurantMenu.route(settings.arguments);
    case '/cust_cart':
      return CustomerCart.route();
  }
  return null;
}
