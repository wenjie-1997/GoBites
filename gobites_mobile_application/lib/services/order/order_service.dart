import 'package:gobites/models/order.dart';
import 'package:gobites/models/order_item.dart';

abstract class OrderService {
  Future<List<Order>> getOrderList();
  Future<List<OrderItem>> getOrderItems(int oid);
  Future changeOrderItemStatus(int id);
  Future setOrderToDelivering(int oid);
  Future removeOrderItem(int id);
  Future<List<Order>> getCustOrderList();
  Future<List<OrderItem>> getCustOrderItems(int oid);
}
