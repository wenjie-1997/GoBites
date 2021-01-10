class LoginResult {
  final String status;
  final String id;

  String getStatus() {
    return status;
  }

  LoginResult({this.status, this.id});

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(status: json['status'] as String, id: json['id']);
  }
}
