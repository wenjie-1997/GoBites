import 'package:gobites/models/user.dart';

class Customer extends User {
  int cid;
  String custname;
  DateTime birthdate;
  String gender;
  String address;
  String email;
  String telephoneNo;
  String image;

  Customer(
      {id,
      this.cid,
      username,
      userType,
      this.custname,
      this.birthdate,
      this.gender,
      this.address,
      this.email,
      this.telephoneNo,
      this.image})
      : super(id: id, username: username, userType: userType);

  Customer.copy(Customer from)
      : this(
            id: from.id,
            cid: from.cid,
            username: from.username,
            userType: from.userType,
            custname: from.custname,
            birthdate: from.birthdate,
            gender: from.gender,
            address: from.address,
            email: from.email,
            telephoneNo: from.telephoneNo,
            image: from.image);

  Customer.fromJson(Map<String, dynamic> json)
      : this(
            id: json['UID'],
            username: json['username'],
            userType: json['usertype'],
            custname: json['custname'],
            birthdate: DateTime.tryParse(json['birthdate']),
            gender: json['gender'],
            address: json['address'],
            email: json['email'],
            telephoneNo: json['telephoneNo'],
            image: json['image']);

  Map<String, dynamic> toJson() => {
        'UID': id,
        'username': username,
        'usertype': userType,
        'custname': custname,
        'birthdate': birthdate.toIso8601String(),
        'gender': gender,
        'address': address,
        'email': email,
        'telephoneNo': telephoneNo,
        'image': image,
      };
}
