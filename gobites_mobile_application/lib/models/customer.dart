import 'package:gobites/models/user.dart';

class Customer extends User {
  int cid;
  String custname;
  DateTime birthdate;
  String gender;
  String address;
  String email;
  String telephoneNo;

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
      this.telephoneNo})
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
            telephoneNo: from.telephoneNo);

  Customer.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          username: json['username'],
          userType: json['usertype'],
          custname: json['custname'],
          birthdate: json['birthdate'],
          gender: json['gender'],
          address: json['address'],
          email: json['email'],
          telephoneNo: json['telephoneNo'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'usertype': userType,
        'custname': custname,
        'birthdate': birthdate,
        'gender': gender,
        'address': address,
        'email': email,
        'telephoneNo': telephoneNo,
      };
}
