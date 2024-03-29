class OrderItem {
  final int id;
  final int quantity;
  final String itemName;
  final double itemPrice;

  OrderItem({
    this.id,
    this.quantity,
    this.itemName,
    this.itemPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      quantity: json['quantity'],
      itemName: json['itemName'],
      itemPrice: ((json['itemPrice'] is int)
          ? json['itemPrice'] + .0
          : json['itemPrice']),
    );
  }
}
