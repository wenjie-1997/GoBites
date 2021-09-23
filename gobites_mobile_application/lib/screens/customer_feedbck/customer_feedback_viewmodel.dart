import 'package:flutter/cupertino.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/order.dart';
import 'package:gobites/models/restaurant.dart';
import 'package:gobites/screens/viewmodel.dart';
import 'package:gobites/services/feedback/feecback_service.dart';
import 'package:gobites/services/order/order_service.dart';
import 'package:gobites/services/restaurant/restaurant_service.dart';

class CustomerFeedbackViewmodel extends Viewmodel {
  FeedbackService get feedbackService => dependency();
  RestaurantService get restaurantService => dependency();
  OrderService get orderService => dependency();

  List<Order> orderList;
  Restaurant restaurant;
  final formKey = GlobalKey<FormState>();
  double _rating;
  double get rating => _rating;
  set rating(double value) {
    _rating = value;
    turnIdle();
  }

  String _comment;
  String get comment => _comment;
  set comment(String value) {
    _comment = value;
    turnIdle();
  }

  void init() async {
    turnBusy();
    orderList = await orderService.getDeliveredOrder();
    for (Order order in orderList) {
      order.orderItemList = await orderService.getOrderItems(order.oid);
    }
    turnIdle();
  }

  void initForGiveFeedback(int oid) async {
    turnBusy();
    restaurant = await restaurantService.getRestaurantByOid(oid);
    _rating = 0;
    _comment = "";
    turnIdle();
  }

  void onSubmit(int oid) async {
    await feedbackService.makeFeedback(oid, restaurant.rid, rating, comment);
    init();
    turnIdle();
  }
}
