class RestDetail {
  final String username;
  final String password;
  final String restaurantname;
  final String ownername;
  final String address;
  final String restaurantstyle;
  final String email;
  final String telephoneNo;

  RestDetail(
      {this.username,
      this.password,
      this.restaurantname,
      this.ownername,
      this.address,
      this.restaurantstyle,
      this.email,
      this.telephoneNo});

  factory RestDetail.fromJson(Map<String, dynamic> json) {
    return RestDetail(
        username: json['username'],
        password: json['password'],
        restaurantname: json['restaurantname'],
        ownername: json['ownername'],
        address: json['address'],
        restaurantstyle: json['restaurantstyle'],
        email: json['email'],
        telephoneNo: json['telephoneNo']);
  }
}

class RestList {
  final String rid;
  final String restaurantname;

  RestList({this.rid, this.restaurantname});

  factory RestList.fromJson(Map<String, dynamic> json) {
    return RestList(rid: json['rid'], restaurantname: json['restaurantname']);
  }
}

class CustRestDetail {
  final String restaurantname;
  final String ownername;
  final String address;
  final String restaurantstyle;
  final String email;
  final String telephoneNo;

  CustRestDetail(
      {this.restaurantname,
      this.ownername,
      this.address,
      this.restaurantstyle,
      this.email,
      this.telephoneNo});

  factory CustRestDetail.fromJson(Map<String, dynamic> json) {
    return CustRestDetail(
        restaurantname: json['restaurantname'],
        ownername: json['ownername'],
        address: json['address'],
        restaurantstyle: json['restaurantstyle'],
        email: json['email'],
        telephoneNo: json['telephoneNo']);
  }
}
