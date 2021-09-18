import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/order.dart';
import 'package:gobites/models/order_item.dart';
import 'package:gobites/screens/viewmodel.dart';
import 'package:gobites/services/order/order_service.dart';

class RestaurantOrderViewmodel extends Viewmodel {
  OrderService get _service => dependency();
  List<Order> orderList;
  Order selectedOrder;

  Future init() async {
    turnBusy();
    orderList = await _service.getOrderList();
    for (Order order in orderList) {
      order.orderItemList = await _service.getOrderItems(order.oid);
    }
    turnIdle();
  }

  Future initForOrderItem(Order order) async {
    selectedOrder = order;
  }

  Future removeOrderItem(Order order, OrderItem item) async {
    turnBusy();
    await _service.removeOrderItem(item.id);
    selectedOrder.orderItemList = await _service.getOrderItems(order.oid);
    turnIdle();
  }

  Future changeOrderItemStatus(Order order, OrderItem item) async {
    await _service.changeOrderItemStatus(item.id);
    selectedOrder.orderItemList = await _service.getOrderItems(order.oid);
    turnIdle();
  }

  Future completeOrder(int oid) async {
    await _service.setOrderToDelivering(oid);
    turnIdle();
  }
}
