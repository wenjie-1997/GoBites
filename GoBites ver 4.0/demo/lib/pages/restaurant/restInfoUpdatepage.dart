import 'dart:convert';

import 'package:demo/modules/http.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/pages/restaurant/restaurantInfo.dart';
import 'package:flutter/material.dart';
import '../registration.dart';

String username;
String password;
String email;
String address;
String telephoneNo;
String restaurantname;
String ownername;
String restaurantstyle;

class RestInfoUpdatePage extends StatefulWidget {
  final RestDetail rest;
  RestInfoUpdatePage({Key key, @required this.rest}) : super(key: key);
  @override
  _RestInfoUpdatePageState createState() => _RestInfoUpdatePageState();
}

class _RestInfoUpdatePageState extends State<RestInfoUpdatePage> {
  Future restUpdate() async {
    final msg = jsonEncode({
      "RID": widget.rest.RID,
      "username": username,
      "password": password,
      "restaurantname": restaurantname,
      "ownername": ownername,
      "restaurantstyle": restaurantstyle,
      "address": address,
      "email": email,
      "telephoneNo": telephoneNo,
    });
    final result = await http_post("/restupdate", msg);
    String status = jsonDecode(result.body);
    //String status = loginResult.getStatus();
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
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    new RestaurantPersonalInfoPage()),
                            (route) => false);
                      })
                ],
              ));
    } else {
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(top: 50, left: 20),
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.orange,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, color: Colors.white)),
              ))),
      Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Update Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Username",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  enabled: false,
                  initialValue: widget.rest.username,
                  decoration: textFieldDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      username = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Restaurant Name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.rest.restaurantname,
                  decoration: textFieldDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your restaurant name';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      custname = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Email",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.rest.email,
                  decoration: textFieldDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Owner Name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.rest.ownername,
                  decoration: textFieldDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the owner name';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Restaurant Type/Style",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                        value: restaurantstyle,
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            restaurantstyle = newValue;
                          });
                        },
                        items: <String>[
                          'Malay',
                          'Chinese',
                          'Indian',
                          'Western',
                          'Arabic',
                          'Others'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.rest.address,
                  decoration: textFieldDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Telephone No.",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.rest.telephoneNo,
                  decoration: textFieldDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the telephone no.';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      telephoneNo = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                      if (username == null) {
                        username = widget.rest.username;
                      }
                      if (password == null) {
                        password = widget.rest.password;
                      }
                      if (email == null) {
                        email = widget.rest.email;
                      }
                      if (address == null) {
                        address = widget.rest.address;
                      }
                      if (telephoneNo == null) {
                        telephoneNo = widget.rest.telephoneNo;
                      }
                      if (restaurantname == null) {
                        restaurantname = widget.rest.restaurantname;
                      }
                      if (restaurantstyle == null) {
                        restaurantstyle = widget.rest.restaurantstyle;
                      }
                      if (ownername == null) {
                        ownername = widget.rest.ownername;
                      }
                      restUpdate();
                    }
                    },
                    child: Text('Update'),
                  ),
                ),
              ],
            ),
          )),
    ]))
      );
  }
}
