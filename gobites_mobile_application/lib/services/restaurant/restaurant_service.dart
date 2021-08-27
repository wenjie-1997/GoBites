import 'package:gobites/models/restaurant.dart';

abstract class RestaurantService {
  Future<Restaurant> getRestaurantProfile();
  Future updateProfile(Restaurant restaurant);
}
