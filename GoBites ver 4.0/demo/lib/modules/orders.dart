import 'dart:ffi';

class Orders {
  final int OID;
  final double totalPrice;
  final String status;
  final DateTime addedDate;
  final double rating;
  final String comment;
  final String address;
  final int hasFeedback;

  Orders(
      {this.OID,
      this.totalPrice,
      this.status,
      this.addedDate,
      this.rating,
      this.comment,
      this.address,
      this.hasFeedback});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
        OID: json['OID'],
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
