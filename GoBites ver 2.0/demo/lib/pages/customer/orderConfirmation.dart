import 'dart:convert';
import 'package:demo/modules/orderItem.dart';
import 'package:demo/modules/orders.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';

class OrderConfirmPage extends StatefulWidget {
  final int oid;
  OrderConfirmPage({Key key, @required this.oid}) : super(key: key);
  @override
  _OrderConfirmPageState createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends State<OrderConfirmPage> {

  List<OrderItem> parseOrder(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
  }

  Future<List<OrderItem>> fetchOrder() async {
    final response = await http_get('/viewordername/' + widget.oid.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseOrder(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load, code = ' + response.statusCode.toString());
    }
  }

  Future<Orders> fetchOrderID() async {
  final response = await http_get('/vieworderid/' + widget.oid.toString());

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Orders.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load album, code = ' + response.statusCode.toString());
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('Order Confirmation'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: 
          Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Text("Order Successful!",
              style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
              ),
              SizedBox(height:30.0,),
              Text("Order ID",
              style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
              ),
              SizedBox(height: 10.0,),
              Text("XXXXXXXX",
              style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
              ),
              SizedBox(height: 20.0,),
              Text("Ordered Item",
              style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
              ),
              SizedBox(height: 10.0,),
              Text("XXXXXXXX",
              style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
              ),
              SizedBox(height: 20.0,),
              Text("Total Price",
              style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
              ),
              SizedBox(height: 10.0,),
              Text("RM XX.XX",
              style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
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
                      'Continue',
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