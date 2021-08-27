import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/restaurant.dart';
import 'package:gobites/services/rest.dart';
import 'package:gobites/services/restaurant/restaurant_service.dart';

class RestaurantServiceRest extends RestaurantService {
  RestService get rest => dependency();

  @override
  Future<Restaurant> getRestaurantProfile() async {
    final json = await rest.get("restaurant/" + user.id.toString());
    return Restaurant.fromJson(json);
  }

  @override
  Future updateProfile(Restaurant restaurant) async {
    print(restaurant.toJson());
    await rest.put('restaurant/' + user.rid.toString(),
        data: restaurant.toJson());
  }
}
