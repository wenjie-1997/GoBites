class User {
  int id;
  String username;
  String userType;

  User({
    this.id,
    this.username,
    this.userType,
  });

  User.copy(User from)
      : this(
          id: from.id,
          username: from.username,
          userType: from.userType,
        );

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json['UID'],
          username: json['username'],
          userType: json['usertype'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'usertype': userType,
      };
}
