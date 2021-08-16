import 'package:flutter/material.dart';

import '../../app/dependencies.dart';
import '../../services/auth/auth_service.dart';
import '../../models/user.dart';
import '../viewmodel.dart';

class RegisterViewmodel extends Viewmodel {
  AuthService get _service => dependency();
  String username;
  String password;
  String usertype;
  DateTime birthdate;
  String custname;
  String gender;
  String email;
  String address;
  String telephoneNo;
  String restaurantname;
  String ownername;
  String restaurantstyle;
  bool validateEmail = false;
  bool validatePassword = false;

  Future<User> authenticate() async {
    turnBusy();

    turnIdle();
    return null;
  }
}
