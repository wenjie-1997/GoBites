import 'package:gobites/models/order_item.dart';

class Order {
  final int oid;
  final double totalPrice;
  final String status;
  final DateTime addedDate;
  final double rating;
  final String comment;
  final String address;
  final int hasFeedback;
  List<OrderItem> orderItemList;
  Order(
      {this.oid,
      this.totalPrice,
      this.status,
      this.addedDate,
      this.rating,
      this.comment,
      this.address,
      this.hasFeedback});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        oid: json['OID'],
        totalPrice: ((json['totalPrice'] is int)
            ? json['totalPrice'] + .0
            : json['totalPrice']),
        status: json['status'],
        addedDate: json['addedDate'] != null
            ? DateTime.parse(json['addedDate'])
            : null,
        rating:
            ((json['rating'] is int) ? json['rating'] + .0 : json['rating']),
        comment: json['comment'],
        address: json['address'],
        hasFeedback: json['hasFeedback']);
  }
}
