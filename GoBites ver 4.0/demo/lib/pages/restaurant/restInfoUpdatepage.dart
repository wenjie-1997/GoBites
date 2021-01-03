import 'dart:convert';

import 'package:demo/modules/http.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/pages/restaurant/restaurantInfo.dart';
import 'package:flutter/material.dart';

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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          backgroundColor: Colors.blue,
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
                    initialValue: widget.rest.username,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        username = value;
                      });
                    },
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  TextFormField(
                      initialValue: widget.rest.password,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          password = value;
                        });
                      }),
                ]),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  TextFormField(
                      initialValue: widget.rest.restaurantname,
                      decoration: const InputDecoration(
                        labelText: 'Restaurant Name',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          restaurantname = value;
                        });
                      }),
                ]),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  TextFormField(
                      initialValue: widget.rest.email,
                      decoration: const InputDecoration(
                        labelText: 'E-mail Address',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          email = value;
                        });
                      }),
                ]),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  TextFormField(
                      initialValue: widget.rest.ownername,
                      decoration: const InputDecoration(
                        labelText: 'Restaurant Owner Name',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          ownername = value;
                        });
                      }),
                ]),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          'Restaurant type/style',
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<String>(
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
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  TextFormField(
                    maxLines: 6,
                    initialValue: widget.rest.address,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        address = value;
                      });
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
        )));
  }
}
