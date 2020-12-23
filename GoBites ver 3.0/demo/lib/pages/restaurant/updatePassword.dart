import 'dart:convert';
import 'dart:ui';
import 'package:demo/modules/restdetail.dart';
import 'package:flutter/material.dart';
import 'package:demo/modules/http.dart';

import 'restaurantInfo.dart';

String oldPassword;
String newPassword;

class RestUpdatePassword extends StatefulWidget {
  final RestDetail rest;
  @override
  RestUpdatePasswordState createState() => RestUpdatePasswordState();
  RestUpdatePassword({Key key, @required this.rest}) : super(key: key);
}

final _formKey = GlobalKey<FormState>();

/// This is the main application widget.
class RestUpdatePasswordState extends State<RestUpdatePassword> {
  Future passwordUpdate() async {
    print(newPassword);
    final msg = jsonEncode({
      "password": newPassword,
      "RID": widget.rest.RID,
    });
    final result = await http_post("/restupdatepassword", msg);
    String status = jsonDecode(result.body);

    if (status == "Update Sucessful") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Update Successful"),
                actions: <Widget>[
                  TextButton(
                      child: Text('Continue'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    new RestaurantPersonalInfoPage()));
                      }),
                ],
              ));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Update Password',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.yellow[200],
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Column(children: <Widget>[
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Old Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else if (oldPassword != widget.rest.password) {
                        return 'Wrong Password';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        oldPassword = value;
                      });
                    },
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Column(children: <Widget>[
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 8 || value.length > 20) {
                        return 'The length of the password must be from 8 to 15.';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        newPassword = value;
                      });
                    },
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Column(children: <Widget>[
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Re-enter New Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value != newPassword) {
                        return 'The password does not match with the one you have entered';
                      }
                      return null;
                    },
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.yellow[800].withOpacity(0.5);
                        return Colors
                            .yellow[800]; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      passwordUpdate();
                    }
                  },
                  child: Text('Update'),
                ),
              ),
            ],
          ),
        ));
  }
}
