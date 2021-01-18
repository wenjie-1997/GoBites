import 'dart:convert';

import 'package:demo/modules/http.dart';
import 'package:demo/pages/restaurant/restMenupage.dart';
import 'package:flutter/material.dart';

import '../registration.dart';

String itemName;
double itemPrice;
String itemDesc;

// ignore: must_be_immutable
class RestAddMenuPage extends StatefulWidget {
  int RID;
  RestAddMenuPage({Key key, @required this.RID}) : super(key: key);
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
      "RID": widget.RID,
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
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.blue,
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
        )*/
        body: Column(children: [
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
                        builder: (BuildContext context) => new RestMenuPage()),
                    (route) => false),
                icon: Icon(Icons.arrow_back, color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text("Add Menu",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
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
                    decoration: textFieldDecoration(),
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
                    decoration: textFieldDecoration(),
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
                    decoration: textFieldDecoration(),
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
                    primary: Colors.orange,
                  ),
                  onPressed: () {
                    insertMenu();
                  },
                  child: Text('Add'),
                ),
              ),
            ],
          ),),
    ]),
    );
  }
}
