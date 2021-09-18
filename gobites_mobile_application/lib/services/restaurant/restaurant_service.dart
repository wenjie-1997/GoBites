import 'package:gobites/models/restaurant.dart';

abstract class RestaurantService {
  Future<Restaurant> getRestaurantProfile();
  Future<List<Restaurant>> getRestaurantList();
  Future updateProfile(Restaurant restaurant);
}
