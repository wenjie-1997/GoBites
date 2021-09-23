import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/cart.dart';
import 'package:gobites/models/customer.dart';
import 'package:gobites/screens/viewmodel.dart';
import 'package:gobites/services/cart/cart_service.dart';
import 'package:gobites/services/customer/customer_service.dart';

class CustomerCartViewmodel extends Viewmodel {
  CartService get _service => dependency();
  CustomerService get custService => dependency();

  List<Cart> cartList;
  double get totalPrice =>
      cartList.fold(0, (prev, cart) => prev + cart.itemPrice * cart.quantity);
  String customerAddress;
  String _deliveryAddress;
  String get deliveryAddress => _deliveryAddress;
  set deliveryAddress(String value) {
    _deliveryAddress = value;
    turnIdle();
  }

  void init() async {
    turnBusy();
    cartList = await _service.getCartList();
    Customer cust = await custService.getCustomerProfile();
    customerAddress = _deliveryAddress = cust.address;
    turnIdle();
  }

  void deleteCardItem(int kid) async {
    await _service.deleteCartItem(kid);
    init();
  }

  void moveToOrder() async {
    await _service.moveToOrder(deliveryAddress);
  }
}
