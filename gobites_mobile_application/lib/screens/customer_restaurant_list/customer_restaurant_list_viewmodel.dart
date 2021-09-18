import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/restaurant.dart';
import 'package:gobites/screens/viewmodel.dart';
import 'package:gobites/services/restaurant/restaurant_service.dart';

class CustomerRestaurantListViewmodel extends Viewmodel {
  RestaurantService get _service => dependency();
  List<Restaurant> restaurantList;
  List<Restaurant> displayedRestaurantList;

  void init() async {
    turnBusy();
    restaurantList = await _service.getRestaurantList();
    displayedRestaurantList = restaurantList;
    turnIdle();
  }

  void displaySearchResult(String text) {
    displayedRestaurantList = restaurantList.where((restsearch) {
      var restName = restsearch.restaurantname.toLowerCase();
      return restName.contains(text);
    }).toList();
    turnIdle();
  }

  double getRestaurantRating() {
    return 3;
  }
}
