import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/order.dart';
import 'package:gobites/models/order_item.dart';
import 'package:gobites/services/order/order_service.dart';
import 'package:gobites/services/rest.dart';

class OrderServiceRest extends OrderService {
  RestService get rest => dependency();
  @override
  Future<List<Order>> getOrderList() async {
    final result = await rest.get('order/restaurant/' + user.rid.toString());
    return result.map<Order>((json) => Order.fromJson(json)).toList();
  }

  Future<List<OrderItem>> getOrderItems(int oid) async {
    final result = await rest.get('order/orderitems/' + oid.toString());
    return result.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
  }

  Future<List<Order>> getCustOrderList() async {
    final result = await rest.get('order/customer/' + user.cid.toString());
    return result.map<Order>((json) => Order.fromJson(json)).toList();
  }

  Future<List<OrderItem>> getCustOrderItems(int oid) async {
    final result = await rest.get('order/customer/orderitems/' + oid.toString());
    return result.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
  }

  @override
  Future changeOrderItemStatus(int id) async {
    await rest.put('order/orderitems/' + id.toString(), data: {});
  }

  Future setOrderToDelivering(int oid) async {
    await rest.put('order/setToDelivering/' + oid.toString(), data: {});
  }

  @override
  Future removeOrderItem(int id) async {
    await rest.delete('order/orderitems/' + id.toString());
  }
}
