class CustDetail {
  final int CID;
  final String username;
  final String password;
  final String custname;
  final DateTime birthdate;
  final String gender;
  final String address;
  final String email;
  final String telephoneNo;

  CustDetail(
      {this.CID,
      this.username,
      this.password,
      this.custname,
      this.birthdate,
      this.gender,
      this.address,
      this.email,
      this.telephoneNo});

  factory CustDetail.fromJson(Map<String, dynamic> json) {
    return CustDetail(
        CID: json['CID'],
        username: json['username'],
        password: json['password'],
        custname: json['custname'],
        birthdate: DateTime.parse(json['birthdate']),
        gender: json['gender'],
        address: json['address'],
        email: json['email'],
        telephoneNo: json['telephoneNo']);
  }
}
