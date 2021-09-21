import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/order.dart';
import 'package:gobites/models/order_item.dart';
import 'package:gobites/screens/viewmodel.dart';
import 'package:gobites/services/order/order_service.dart';

class CustomerOrderViewmodel extends Viewmodel {
  OrderService get _service => dependency();
  List<Order> orderList;
  List<OrderItem> itemList;
  Order selectedOrder;

  Future init() async {
    turnBusy();
    orderList = await _service.getCustOrderList();
    for (Order order in orderList) {
      order.orderItemList = await _service.getCustOrderItems(order.oid);
    }
    turnIdle();
  }
}
