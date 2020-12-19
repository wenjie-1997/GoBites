class OrderItem {
  final int ID;
  final int quantity;
  final String itemName;
  final double itemPrice;

  OrderItem({
    this.ID,
    this.quantity,
    this.itemName,
    this.itemPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      ID: json['id'],
      quantity: json['quantity'],
      itemName: json['itemName'],
      itemPrice: ((json['itemPrice'] is int)
          ? json['itemPrice'] + .0
          : json['itemPrice']),
    );
  }
}
