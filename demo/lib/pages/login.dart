import 'dart:convert';
import 'dart:ui';

import 'package:demo/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/registration.dart';
import 'package:demo/modules/user.dart';
import 'package:demo/modules/http.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<LoginResult> loginResult;
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _validateEmail = false;
  bool _validatePassword = false;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usernameField = TextField(
      controller: _username,
      obscureText: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Username",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        errorText: _validateEmail ? 'Username Can\'t Be Empty' : null,
      ),
    );

    final passwordField = TextField(
      controller: _password,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        errorText: _validatePassword ? 'Password Can\'t Be Empty' : null,
      ),
    );

    Future checkCredential() async {
      final msg =
          jsonEncode({"username": _username.text, "password": _password.text});
      final result = await http_post("/login", msg);
      String status = jsonDecode(result.body);
      //String status = loginResult.getStatus();
      if (status == "Login Sucessful") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => AlertDialog(
                  title:
                      Text("Invalid username or password, please try again."),
                  actions: <Widget>[
                    TextButton(
                        child: Text('Continue'),
                        onPressed: () => Navigator.of(context).pop()),
                  ],
                ));
      }
    }

    final loginButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.red,
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            setState(() {
              _username.text.isEmpty
                  ? _validateEmail = true
                  : _validateEmail = false;
            });
            setState(() {
              _password.text.isEmpty
                  ? _validatePassword = true
                  : _validatePassword = false;
            });
            if (!_validateEmail && !_validatePassword) {
              checkCredential();
            }
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.amber, 
                fontSize: 20.0, 
                letterSpacing: 3.0
                ),
          ),
        ));

    final registrationlink = Container(
      child: InkWell(
          child: new Text(
            'New user? Register Now',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue[800],
            ),
          ),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Register()))),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.yellow[200],
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('GoBites',
                    style: TextStyle(
                        fontSize: 50.0,
                        letterSpacing: 3.0,
                        color: Colors.black,
                        fontFamily: 'Vibur'
                      )
                ),
                SizedBox(height: 45.0),
                usernameField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
                ),
                registrationlink,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
