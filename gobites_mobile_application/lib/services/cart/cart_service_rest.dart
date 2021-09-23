import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/cart.dart';
import 'package:gobites/services/cart/cart_service.dart';
import 'package:gobites/services/rest.dart';

class CartServiceRest extends CartService {
  RestService get rest => dependency();

  @override
  Future addToCart(int mid, int quantity) async {
    await rest.post('cart/addToCart/' + user.cid.toString(),
        data: {'MID': mid, 'quantity': quantity});
  }

  Future deleteCartItem(int kid) async {
    await rest.delete('cart/' + kid.toString());
  }

  @override
  Future<List<Cart>> getCartList() async {
    final result = await rest.get('cart/' + user.cid.toString());
    List<Cart> cartList =
        result.map<Cart>((json) => Cart.fromJson(json)).toList();
    return cartList;
  }

  @override
  Future moveToOrder(String address) async {
    await rest.post('cart/move_to_order/' + user.cid.toString(),
        data: {'address': address});
  }
}
