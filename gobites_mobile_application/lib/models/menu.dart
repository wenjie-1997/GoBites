class Menu {
  int mid;
  String name;
  double price;
  String description;

  Menu({this.mid, this.name, this.price, this.description});

  Menu.fromJson(Map<String, dynamic> json)
      : this(
            mid: json['MID'],
            name: json['itemName'],
            price: json['itemPrice'] + .0,
            description: json['itemDesc']);

  Map<String, dynamic> toJson() => {
        'MID': mid,
        'itemName': name,
        'itemPrice': price,
        'itemDesc': description
      };
}
