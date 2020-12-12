class LoginResult {
  final String status;
  final String id;
  final String fk_rid;

  String getStatus() {
    return status;
  }

  LoginResult({this.status, this.id, this.fk_rid});

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
        status: json['status'] as String,
        id: json['id'],
        fk_rid: json['fk_rid']);
  }
}
