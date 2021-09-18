import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/menu.dart';
import 'package:gobites/models/restaurant.dart';
import 'package:gobites/screens/viewmodel.dart';
import 'package:gobites/services/cart/cart_service.dart';
import 'package:gobites/services/menu/menu_service.dart';

class CustomerRestaurantMenuViewmodel extends Viewmodel {
  MenuService get menuService => dependency();
  CartService get cartService => dependency();
  List<Menu> menuList;
  int quantity = 0;

  void init(Restaurant restaurant) async {
    turnBusy();
    menuList = await menuService.getMenuList(rid: restaurant.rid);
    turnIdle();
  }

  void addToCart(int mid, int quantity) async {
    await cartService.addToCart(mid,quantity);
    turnIdle();
  }
}
