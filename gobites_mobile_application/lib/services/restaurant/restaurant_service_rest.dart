import 'dart:io';

import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/restaurant.dart';
import 'package:gobites/services/rest.dart';
import 'package:gobites/services/restaurant/restaurant_service.dart';

class RestaurantServiceRest extends RestaurantService {
  RestService get rest => dependency();

  @override
  Future<Restaurant> getRestaurantProfile() async {
    final json = await rest.get("restaurant/" + user.id.toString());
    if (json['image'] != null)
      json['image'] = rest.baseUrl + '/' + json['image'];
    print(json['image']);
    return Restaurant.fromJson(json);
  }

  @override
  Future updateProfile(Restaurant restaurant) async {
    await rest.put('restaurant/' + user.rid.toString(),
        data: restaurant.toJson());
  }

  @override
  Future<List<Restaurant>> getRestaurantList() async {
    final result = await rest.get('restaurant');
    List<Restaurant> restaurants =
        result.map<Restaurant>((json) => Restaurant.fromJson(json)).toList();
    for (var restaurant in restaurants) {
      if (restaurant.image != null)
        restaurant.image = rest.baseUrl + '/' + restaurant.image;
    }
    return restaurants;
  }

  Future<Restaurant> getRestaurantByOid(int oid) async {
    final json = await rest.get('restaurant/byOid/' + oid.toString());
    return Restaurant.fromJson(json);
  }

  @override
  Future uploadImage(String name, String image) async {
    await rest.post('user/upload_image',
        data: {'rid': user.rid, 'name': name, 'image': image});
  }

  @override
  Future<bool> checkPassword(String password) async {
    bool result = await rest.post('user/check_password/' + user.id.toString(),
        data: {'password': password});
    return result;
  }

  Future updatePassword(String password) async {
    await rest.post('user/update_password/' + user.id.toString(),
        data: {'password': password});
  }
}
