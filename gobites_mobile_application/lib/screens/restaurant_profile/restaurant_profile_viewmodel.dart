import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/restaurant.dart';
import 'package:gobites/services/restaurant/restaurant_service.dart';

import '../viewmodel.dart';

class RestProfileViewmodel extends Viewmodel {
  RestaurantService get _service => dependency();
  Restaurant restaurant;

  void init() async {
    turnBusy();
    restaurant = await _service.getRestaurantProfile();
    turnIdle();
  }
}
