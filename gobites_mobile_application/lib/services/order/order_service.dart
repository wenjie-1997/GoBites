import 'package:gobites/models/order.dart';
import 'package:gobites/models/order_item.dart';

abstract class OrderService {
  Future<List<Order>> getRestaurantOrder();
  Future<List<Order>> getCustomerOrder();
  Future<List<Order>> getDeliveredOrder();
  Future<List<OrderItem>> getOrderItems(int oid);
  Future changeOrderItemStatus(int id);
  Future setOrderToDelivering(int oid);
  Future removeOrderItem(int id);
}
