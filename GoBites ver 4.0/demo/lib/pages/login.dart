import 'dart:convert';
import 'dart:ui';
import 'package:demo/pages/customer/custHomepage.dart';
import 'package:demo/pages/restaurant/restHomepage.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/registration.dart';
import 'package:demo/modules/user.dart';
import 'package:demo/modules/http.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

// ignore: non_constant_identifier_names
String login_id;

class _LoginState extends State<Login> {
  LoginResult loginResult;
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
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        hintText: "Username",
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        errorText: _validateEmail ? 'Username Can\'t Be Empty' : null,
      ),
    );

    final passwordField = TextField(
      controller: _password,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        hintText: "Password",
        prefixIcon: Icon(Icons.vpn_key),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        errorText: _validatePassword ? 'Password Can\'t Be Empty' : null,
      ),
    );

    Future checkCredential() async {
      final msg =
          jsonEncode({"username": _username.text, "password": _password.text});
      final result = await http_post("/login", msg);
      loginResult = LoginResult.fromJson(jsonDecode(result.body));
      if (loginResult.status == "Login Sucessful as Customer") {
        login_id = loginResult.id;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CustomerHomePage()));
      } else if (loginResult.status == "Login Sucessful as Restaurant") {
        login_id = loginResult.id;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RestHomePage()));
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

    final loginButton = Row(children: [
      Expanded(
          child: Container(
              child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.orange,
                  child: MaterialButton(
                    padding: EdgeInsets.all(10),
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
                          color: Colors.white,
                          fontSize: 18.0,
                          letterSpacing: 2.0),
                    ),
                  ))))
    ]);

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

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.yellow[100], Colors.orange[200]])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
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
                            fontFamily: 'Vibur')),
                    SizedBox(height: 80.0),
                    usernameField,
                    SizedBox(height: 20.0),
                    passwordField,
                    SizedBox(
                      height: 20.0,
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
        ));
  }
}
