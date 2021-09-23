import 'package:gobites/models/restaurant.dart';

abstract class RestaurantService {
  Future<Restaurant> getRestaurantProfile();
  Future<List<Restaurant>> getRestaurantList();
  Future<Restaurant> getRestaurantByOid(int oid);
  Future updateProfile(Restaurant restaurant);
  Future uploadImage(String name, String image);
  Future<bool> checkPassword(String password);
  Future updatePassword(String password);
}
