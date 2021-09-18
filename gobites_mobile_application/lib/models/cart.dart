class Cart {
  final String itemName;
  final double itemPrice;
  final int quantity;
  final int kid;

  Cart({this.itemName, this.itemPrice, this.quantity, this.kid});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        itemName: json['itemName'],
        itemPrice: ((json['itemPrice'] is int)
            ? json['itemPrice'] + .0
            : json['itemPrice']),
        quantity: json['quantity'],
        kid: json['KID']);
  }
}
