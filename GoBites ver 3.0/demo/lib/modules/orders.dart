class Orders {
  final int OID;
  final double totalPrice;
  final String status;

  Orders({this.OID, this.totalPrice, this.status});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      OID: json['OID'],
      totalPrice: ((json['totalPrice'] is int)
          ? json['totalPrice'] + .0
          : json['totalPrice']),
      status: json['status'],
    );
  }
}
