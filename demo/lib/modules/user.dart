class LoginResult {
  final String status;

  String getStatus() {
    return status;
  }

  LoginResult({this.status});

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      status: json['status'] as String,
    );
  }
}
