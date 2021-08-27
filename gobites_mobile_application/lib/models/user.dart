class User {
  int id;
  String username;
  String userType;
  int rid;
  int cid;

  User({this.id, this.username, this.userType, this.rid, this.cid});

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
          rid: json['fk_rid'],
          cid: json['fk_cid'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'usertype': userType,
      };
}
