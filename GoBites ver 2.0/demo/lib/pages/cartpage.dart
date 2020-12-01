import 'dart:convert';
import 'package:demo/modules/menu.dart';
import 'package:flutter/material.dart';
import 'package:demo/modules/http.dart';
import 'package:demo/modules/restdetail.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
        title: Text('My Cart'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        children: <Widget>[
              Card(
                elevation: 4.0,
                child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/default.png'),
                          radius: 30.0,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('McChicken'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                            'RM 10.00'),
                      ),
                    ],
                  ),
                )
              ],
            ),
              ),
            ],
          ),
    );
  }
}