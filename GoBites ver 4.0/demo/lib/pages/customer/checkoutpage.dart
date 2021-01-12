import 'dart:convert';
import 'package:demo/modules/orderItem.dart';
import 'package:demo/modules/orders.dart';
import 'package:demo/pages/customer/custHomepage.dart';
import 'package:demo/pages/customer/orderConfirmation.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';

Orders orders;
String address;

class Checkoutpage extends StatefulWidget {
  final int oid;
  Checkoutpage({Key key, @required this.oid}) : super(key: key);
  @override
  _CheckoutpageState createState() => _CheckoutpageState();
}

class _CheckoutpageState extends State<Checkoutpage> {
  final _formKey = GlobalKey<FormState>();
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

  Future insertAddress() async {
    final msg = jsonEncode({"address": address, "OID": widget.oid});
    final result = await http_post("/insertorderaddress", msg);
    String status = jsonDecode(result.body);
    print(status);
    if (status == "Insert Address Successful") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Insert Address successful"),
                actions: <Widget>[
                  TextButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OrderConfirmPage(oid: orders.OID)));
                    },
                  )
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

  Future<Orders> futureOrder;
  Future<List<OrderItem>> futureOrderList;

  @override
  void initState() {
    super.initState();
    futureOrder = fetchOrderID();
    futureOrderList = fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop()),
        title: Text('Check Out'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<Orders>(
          future: futureOrder,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              orders = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Order ID: ${orders.OID.toString()}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Ordered Item",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        FutureBuilder(
                            future: futureOrderList,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return orderListView(context, snapshot);
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error);
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Total Price: RM ${orders.totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(children: <Widget>[
                                    TextFormField(
                                      maxLines: 3,
                                      initialValue: cust.address,
                                      decoration: const InputDecoration(
                                        labelText:
                                            'This is your current address, retype to change delivery address',
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
                                    RaisedButton(
                                      child: Text(
                                        'Insert Address',
                                        textAlign: TextAlign.center,
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          if (address == null) {
                                            address = cust.address;
                                          }
                                          insertAddress();
                                        }
                                      },
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                    ),
                                  ]),
                                ),
                              ],
                            )),
                      ],
                    ),
                    /*Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text(
                            'Continue',
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                      ),
                    )*/
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget orderListView(BuildContext context, AsyncSnapshot snapshot) {
    List<OrderItem> orderitem = snapshot.data;
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
        itemCount: snapshot.data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        orderitem[index].itemName,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${orderitem[index].quantity.toString()}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'RM ${(orderitem[index].itemPrice * orderitem[index].quantity).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          );
        });
  }
}
