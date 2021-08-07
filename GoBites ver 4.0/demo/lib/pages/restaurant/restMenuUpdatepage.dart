import 'dart:convert';

import 'package:demo/modules/http.dart';
import 'package:demo/modules/menu.dart';
import 'package:demo/pages/restaurant/restMenupage.dart';
import 'package:flutter/material.dart';

import '../registration.dart';

class RestMenuUpdatePage extends StatefulWidget {
  final Menu menu;
  RestMenuUpdatePage({Key key, @required this.menu}) : super(key: key);

  @override
  _RestMenuUpdatePageState createState() => _RestMenuUpdatePageState();
}

String itemName;
double itemPrice;
String itemDesc;

class _RestMenuUpdatePageState extends State<RestMenuUpdatePage> {
  Future menuUpdate() async {
    print(itemName +
        itemPrice.toString() +
        itemDesc +
        widget.menu.MID.toString());
    final msg = jsonEncode({
      "itemName": itemName,
      "itemPrice": itemPrice,
      "itemPhoto": "default.png",
      "itemDesc": itemDesc,
      "MID": widget.menu.MID,
    });
    final result = await http_post("/menuupdate", msg);
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
                                builder: (context) => new RestMenuPage()),
                            (route) => false);
                      }),
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
  void initState() {
    super.initState();
    itemName = widget.menu.itemName;
    itemPrice = widget.menu.itemPrice;
    itemDesc = widget.menu.itemDesc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 40, left: 20),
          child: Stack(children: [
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.orange,
                shape: CircleBorder(),
              ),
              child: IconButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new RestMenuPage()),
                      (route) => false),
                  icon: Icon(Icons.arrow_back, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Update Menu",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30))),
            )
          ]),
        ),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Menu name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.menu.itemName,
                    decoration: textFieldDecoration(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the name';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        itemName = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Price (RM)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.menu.itemPrice.toStringAsFixed(2),
                    decoration: textFieldDecoration(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the price';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        itemPrice = double.parse(value);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 3,
                    initialValue: widget.menu.itemDesc,
                    decoration: textFieldDecoration(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        itemDesc = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (itemName == null) {
                            itemName = widget.menu.itemName;
                          }
                          if (itemPrice == null) {
                            itemPrice = widget.menu.itemPrice;
                          }
                          if (itemDesc == null) {
                            itemDesc = widget.menu.itemDesc;
                          }
                          menuUpdate();
                        }
                      },
                      child: Text('Update'),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        )
      ]),
    ));
  }
}
