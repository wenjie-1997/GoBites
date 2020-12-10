class Orders {
  final int OID;

  Orders({this.OID});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(OID: json['OID']);
  }
}
