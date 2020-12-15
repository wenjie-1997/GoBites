class Menu {
  final String itemName;
  final double itemPrice;
  final String itemPhoto;
  final String itemDesc;
  final int MID;

  Menu({this.itemName, this.itemPrice, this.itemPhoto, this.itemDesc, this.MID});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
        itemName: json['itemName'],
        itemPrice: ((json['itemPrice'] is int)
            ? json['itemPrice'] + .0
            : json['itemPrice']),
        itemPhoto: json['itemPhoto'],
        itemDesc: json['itemDesc'],
        MID:json['MID']);
  }
}
