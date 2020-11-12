import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:demo/pages/registration.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.red,
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {},
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.amber, fontSize: 20.0, letterSpacing: 3.0),
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
                        color: Colors.black)),
                SizedBox(height: 45.0),
                emailField,
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
