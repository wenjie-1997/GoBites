import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/order.dart';
import 'package:gobites/screens/viewmodel.dart';
import 'package:gobites/services/order/order_service.dart';

class CustomerOrderViewmodel extends Viewmodel {
  OrderService get _service => dependency();
  List<Order> orderList;

  void init() async {
    turnBusy();
    orderList = await _service.getCustomerOrder();
    for (Order order in orderList) {
      order.orderItemList = await _service.getOrderItems(order.oid);
    }
    turnIdle();
  }
}
