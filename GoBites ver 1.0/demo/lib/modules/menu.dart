class Menu {
  final String itemName;
  final double itemPrice;
  final String itemPhoto;
  final String itemDesc;

  Menu({this.itemName, this.itemPrice, this.itemPhoto, this.itemDesc});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
        itemName: json['itemName'],
        itemPrice: ((json['itemPrice'] is int)
            ? json['itemPrice'] + .0
            : json['itemPrice']),
        itemPhoto: json['itemPhoto'],
        itemDesc: json['itemDesc']);
  }
}
