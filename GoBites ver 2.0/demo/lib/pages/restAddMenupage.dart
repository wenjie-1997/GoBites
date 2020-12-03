import 'dart:convert';

import 'package:demo/modules/http.dart';
import 'package:demo/pages/restMenupage.dart';
import 'package:flutter/material.dart';

String itemName;
double itemPrice;
String itemDesc;

class RestAddMenuPage extends StatefulWidget {
  @override
  _RestAddMenuPageState createState() => _RestAddMenuPageState();
}

class _RestAddMenuPageState extends State<RestAddMenuPage> {
  Future insertMenu() async {
    final msg = jsonEncode({
      "itemName": itemName,
      "itemPrice": itemPrice,
      "itemPhoto": "default.png",
      "itemDesc": itemDesc,
      "RID": 2,
    });
    final result = await http_post("/addmenu", msg);
    String status = jsonDecode(result.body);
    if (status == "Insert Sucessful") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Insert Sucessful"),
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
          title: Text('Add Menu'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Menu Name',
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
                    insertMenu();
                  },
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ));
  }
}
