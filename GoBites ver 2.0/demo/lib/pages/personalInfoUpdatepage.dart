import 'dart:convert';

import 'package:flutter/material.dart';

import '../modules/custdetail.dart';
import '../modules/http.dart';
import 'personalInfo.dart';
import 'registration.dart';

String username;
String password;
String usertype;
DateTime birthdate;
String custname;
String gender;
String email;
String address;
String telephoneNo;

class PersonalInfoUpdatePage extends StatefulWidget {
  final CustDetail cust;
  PersonalInfoUpdatePage({Key key, @required this.cust}) : super(key: key);

  @override
  _PersonalInfoUpdatePageState createState() => _PersonalInfoUpdatePageState();
}

class _PersonalInfoUpdatePageState extends State<PersonalInfoUpdatePage> {
  final _formKey = GlobalKey<FormState>();

  Future custUpdate() async {
    final msg = jsonEncode({
      "username": username,
      "password": password,
      "usertype": usertype,
      "restaurantname": restaurantname,
      "ownername": ownername,
      "address": address,
      "restaurantstyle": restaurantstyle,
      "email": email,
      "telephoneNo": telephoneNo,
    });
    final result = await http_post("/restregister", msg);
    String status = jsonDecode(result.body);
    //String status = loginResult.getStatus();
    if (status == "Register Sucessful") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Resgister Successful"),
                actions: <Widget>[
                  TextButton(
                      child: Text('Continue'),
                      onPressed: () => Navigator.of(context).pop()),
                ],
              ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PersonalInfoPage()));
    } else {
      // AlertDialog(
      //   title: Text(status),
      //   actions: <Widget>[
      //     TextButton(
      //       child: Text('Continue'),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //   ],
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.red,
        title: Text('Update Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                TextFormField(
                  initialValue: widget.cust.username,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                TextFormField(
                  initialValue: widget.cust.password,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                TextFormField(
                  initialValue: widget.cust.username,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                TextFormField(
                  initialValue: widget.cust.email,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                TextFormField(
                  maxLines: 6,
                  initialValue: widget.cust.address,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    custUpdate();
                  }
                },
                child: Text('Update'),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
