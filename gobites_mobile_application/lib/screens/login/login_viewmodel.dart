import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/user.dart';
import 'package:gobites/services/auth/auth_service.dart';

// import '../../app/dependencies.dart';
// import '../../models/user.dart';
import '../viewmodel.dart';

class LoginViewmodel extends Viewmodel {
  AuthService get _service => dependency();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool validateEmail = false;
  bool validatePassword = false;

  LoginViewmodel();

  Future<User> checkCredential() async {
    return await _service.checkCredential(
        username: usernameController.text, password: passwordController.text);
  }
  // Future checkCredential() async {
  //   final msg =
  //       jsonEncode({"username": _username.text, "password": _password.text});
  //   final result = await http_post("/login", msg);
  //   loginResult = LoginResult.fromJson(jsonDecode(result.body));
  //   if (loginResult.status == "Login Sucessful as Customer") {
  //     login_id = loginResult.id;
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context) => CustomerHomePage()));
  //   } else if (loginResult.status == "Login Sucessful as Restaurant") {
  //     login_id = loginResult.id;
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => RestHomePage()));
  //   } else {
  //     showDialog<void>(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) => AlertDialog(
  //               title:
  //                   Text("Invalid username or password, please try again."),
  //               actions: <Widget>[
  //                 TextButton(
  //                     child: Text('Continue'),
  //                     onPressed: () => Navigator.of(context).pop()),
  //               ],
  //             ));
  //   }
  // }

}
