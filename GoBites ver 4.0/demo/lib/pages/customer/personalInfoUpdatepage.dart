import 'dart:convert';
import 'package:flutter/material.dart';
import '../../modules/custdetail.dart';
import '../../modules/http.dart';
import 'personalInfo.dart';

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
                                builder: (context) => new PersonalInfoPage()),
                            (route) => false);
                      }),
                ],
              ));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
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
                  enabled: false,
                  initialValue: widget.cust.username,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
              ]),
            ),
            // Container(
            //   padding: EdgeInsets.all(10.0),
            //   child: Column(children: <Widget>[
            //     TextFormField(
            //       enabled: ,
            //       initialValue: widget.cust.password,
            //       decoration: const InputDecoration(
            //         labelText: 'Password',
            //       ),
            //       validator: (value) {
            //         if (value.isEmpty) {
            //           return 'Please enter some text';
            //         }
            //         return null;
            //       },
            //       onChanged: (String value) {
            //         setState(() {
            //           password = value;
            //         });
            //       },
            //     ),
            //   ]),
            // ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                TextFormField(
                  initialValue: widget.cust.custname,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      custname = value;
                    });
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
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
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
                  onChanged: (String value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                TextFormField(
                  initialValue: widget.cust.telephoneNo,
                  decoration: const InputDecoration(
                    labelText: 'Telephone No.',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      telephoneNo = value;
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
    );
  }
}
