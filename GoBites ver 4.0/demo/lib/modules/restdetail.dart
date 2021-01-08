class RestDetail {
  final int RID;
  final String username;
  final String password;
  final String restaurantname;
  final String ownername;
  final String address;
  final String restaurantstyle;
  final String email;
  final String telephoneNo;
  final String image;

  RestDetail(
      {this.RID,
      this.username,
      this.password,
      this.restaurantname,
      this.ownername,
      this.address,
      this.restaurantstyle,
      this.email,
      this.telephoneNo,
      this.image});

  factory RestDetail.fromJson(Map<String, dynamic> json) {
    return RestDetail(
        RID: json['RID'],
        username: json['username'],
        password: json['password'],
        restaurantname: json['restaurantname'],
        ownername: json['ownername'],
        address: json['address'],
        restaurantstyle: json['restaurantstyle'],
        email: json['email'],
        telephoneNo: json['telephoneNo'],
        image: json['image']);
  }
}

class RestList {
  final int RID;
  final String restaurantname;
  final String ownername;
  final String address;
  final String restaurantstyle;
  final String email;
  final String telephoneNo;
  final String image;

  RestList(
      {this.RID,
      this.restaurantname,
      this.ownername,
      this.address,
      this.restaurantstyle,
      this.email,
      this.telephoneNo,
      this.image});

  factory RestList.fromJson(Map<String, dynamic> json) {
    return RestList(
        RID: json['RID'] as int,
        restaurantname: json['restaurantname'],
        ownername: json['ownername'],
        address: json['address'],
        restaurantstyle: json['restaurantstyle'],
        email: json['email'],
        telephoneNo: json['telephoneNo'],
        image: json['image']);
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
