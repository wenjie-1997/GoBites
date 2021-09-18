import 'package:gobites/models/user.dart';

class Restaurant extends User {
  int rid;
  String restaurantname;
  String ownername;
  String restaurantstyle;
  String address;
  String email;
  String telephoneNo;
  double rating;

  Restaurant(
      {id,
      this.rid,
      username,
      userType,
      this.restaurantname,
      this.ownername,
      this.restaurantstyle,
      this.address,
      this.email,
      this.telephoneNo,
      this.rating})
      : super(id: id, username: username, userType: userType);

  Restaurant.copy(Restaurant from)
      : this(
            id: from.id,
            rid: from.rid,
            username: from.username,
            userType: from.userType,
            restaurantname: from.restaurantname,
            ownername: from.ownername,
            restaurantstyle: from.restaurantstyle,
            address: from.address,
            email: from.email,
            telephoneNo: from.telephoneNo,
            rating: from.rating);

  Restaurant.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            rid: json['RID'],
            username: json['username'],
            userType: json['usertype'],
            restaurantname: json['restaurantname'],
            ownername: json['ownername'],
            restaurantstyle: json['restaurantstyle'],
            address: json['address'],
            email: json['email'],
            telephoneNo: json['telephoneNo'],
            rating: json['rating'] == null ? -1 : json['rating'] + .0);

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'usertype': userType,
        'restaurantname': restaurantname,
        'ownername': ownername,
        'restaurantstyle': restaurantstyle,
        'address': address,
        'email': email,
        'telephoneNo': telephoneNo,
      };
}
