import 'dart:convert';
import 'package:demo/pages/customer/custHomepage.dart';
import 'package:flutter/material.dart';
import '../../modules/custdetail.dart';
import '../../modules/http.dart';
import '../registration.dart';

String username;
String password;
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
      "CID": widget.cust.CID,
      "custname": custname,
      "address": address,
      "email": email,
      "telephoneNo": telephoneNo,
    });
    final result = await http_post("/custupdate", msg);
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
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new CustHomePage()),
                            (route) => false);
                      }),
                ],
              ));
    } else {}
  }

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
                  initialValue: widget.cust.username,
                  decoration: textFieldDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your user name';
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
                  child: Text("Username",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.cust.custname,
                  decoration: textFieldDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your name';
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
                  initialValue: widget.cust.email,
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
                  child: Text("Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.cust.address,
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
                  initialValue: widget.cust.telephoneNo,
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
                        if (email == null) {
                          email = widget.cust.email;
                        }
                        if (address == null) {
                          address = widget.cust.address;
                        }
                        if (telephoneNo == null) {
                          telephoneNo = widget.cust.telephoneNo;
                        }
                        if (custname == null) {
                          custname = widget.cust.custname;
                        }
                        custUpdate();
                      }
                    },
                    child: Text('Update'),
                  ),
                ),
              ],
            ),
          )),
    ])));
  }
}
