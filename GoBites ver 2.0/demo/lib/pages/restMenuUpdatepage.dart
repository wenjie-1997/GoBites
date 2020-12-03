import 'dart:convert';

import 'package:demo/modules/http.dart';
import 'package:demo/modules/menu.dart';
import 'package:demo/pages/restMenupage.dart';
import 'package:flutter/material.dart';



class RestMenuUpdatePage extends StatefulWidget {
  final Menu menu;
  RestMenuUpdatePage({Key key, @required this.menu}) : super(key: key);

  @override
  _RestMenuUpdatePageState createState() => _RestMenuUpdatePageState();
}

class _RestMenuUpdatePageState extends State<RestMenuUpdatePage> {
  String itemName;
  double itemPrice;
  String itemDesc;
  
  Future menuUpdate() async {
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
                      onPressed: () => Navigator.of(context).pop()),
                ],
              ));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => new RestMenuPage()));
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
  void initState() {
    super.initState();
    itemName = widget.menu.itemName;
    itemPrice = widget.menu.itemPrice;
    itemDesc = widget.menu.itemDesc;
  }

  final _formKey = GlobalKey<FormState>();
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
        title: Text('Update Menu'),
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
                  initialValue: itemName,
                  decoration: const InputDecoration(
                    labelText: 'Menu name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      itemName = value;
                    });
                  },
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                TextFormField(
                  initialValue: itemPrice.toStringAsFixed(2),
                  decoration: const InputDecoration(
                    labelText: 'Price (RM)',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some digit';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      itemPrice = double.parse(value);
                    });
                  },
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                TextFormField(
                  maxLines: 3,
                  initialValue: itemDesc,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      itemDesc = value;
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
                  menuUpdate();
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
