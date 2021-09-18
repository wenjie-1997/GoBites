import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/cart.dart';
import 'package:gobites/screens/viewmodel.dart';
import 'package:gobites/services/cart/cart_service.dart';

class CustomerCartViewmodel extends Viewmodel {
  CartService get _service => dependency();
  List<Cart> cartList;
  double get totalPrice =>
      cartList.fold(0, (prev, cart) => prev + cart.itemPrice * cart.quantity);

  void init() async {
    turnBusy();
    cartList = await _service.getCartList();
    turnIdle();
  }

  void deleteCardItem(int kid) async {
    await _service.deleteCartItem(kid);
    init();
  }
}
