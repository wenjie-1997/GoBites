import 'dart:convert';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';

class Checkoutpage extends StatefulWidget {
  @override
  _CheckoutpageState createState() => _CheckoutpageState();
}

class _CheckoutpageState extends State<Checkoutpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop()),
          title: Text('Check Out'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text('McChicken'),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(child: Text('Quantity: 3')),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text('RM 20.00'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text(
                      'Pay Now',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {},
                    color: Colors.red,
                    textColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
