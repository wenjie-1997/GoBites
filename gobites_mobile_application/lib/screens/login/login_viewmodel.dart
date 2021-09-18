import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/user.dart';
import 'package:gobites/services/auth/auth_service.dart';

import '../../app/dependencies.dart';
import '../viewmodel.dart';

class LoginViewmodel extends Viewmodel {
  AuthService get _service => dependency();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<User> checkCredential() async {
    turnBusy();
    final user = await _service.checkCredential(
        username: usernameController.text, password: passwordController.text);
    turnIdle();
    return user;
  }
}
