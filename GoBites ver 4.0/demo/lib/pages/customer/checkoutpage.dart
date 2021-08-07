import 'dart:convert';
import 'package:demo/modules/cart.dart';
import 'package:demo/modules/orderItem.dart';
import 'package:demo/modules/orders.dart';
import 'package:demo/pages/customer/orderConfirmation.dart';
import '../registration.dart';
import 'cartpage.dart' as cp;
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';
import 'custHomepage.dart';

Orders orders;
String address;

class Checkoutpage extends StatefulWidget {
  final double totalPrice;
  Checkoutpage({Key key, @required this.totalPrice}) : super(key: key);
  @override
  _CheckoutpageState createState() => _CheckoutpageState();
}

class _CheckoutpageState extends State<Checkoutpage> {
  List<OrderItem> parseOrder(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
  }

  moveToOrder() async {
    final msg = jsonEncode({
      "CID": cust.CID,
      "address": address,
    });
    final result = await http_post("/movetoorder", msg);
    Orders orders = Orders.fromJson(jsonDecode(result.body));
    //String status = loginResult.getStatus();
    if (orders.OID != null) {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Order Successful"),
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
    }
  }

  // Future<List<OrderItem>> fetchOrder() async {
  //   final response = await http_get('/viewordername/' + widget.oid.toString());
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return parseOrder(response.body);
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception(
  //         'Failed to load, code = ' + response.statusCode.toString());
  //   }
  // }

  // Future<Orders> fetchOrderID() async {
  //   final response = await http_get('/vieworderid/' + widget.oid.toString());

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return Orders.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception(
  //         'Failed to load album, code = ' + response.statusCode.toString());
  //   }
  // }

  // Future insertAddress() async {
  //   final msg = jsonEncode({"address": address, "OID": widget.oid});
  //   final result = await http_post("/insertorderaddress", msg);
  //   String status = jsonDecode(result.body);
  //   print(status);
  //   if (status == "Insert Address Successful") {
  //     showDialog<void>(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) => AlertDialog(
  //               title: Text("Insert Address successful"),
  //               actions: <Widget>[
  //                 TextButton(
  //                   child: Text('Continue'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     Navigator.pushReplacement(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) =>
  //                                 OrderConfirmPage(oid: orders.OID)));
  //                   },
  //                 )
  //               ],
  //             ));
  //   } else {
  //     // AlertDialog(
  //     //   title: Text(status),
  //     //   actions: <Widget>[
  //     //     TextButton(
  //     //       child: Text('Continue'),
  //     //       onPressed: () {
  //     //         Navigator.of(context).pop();
  //     //       },
  //     //     ),
  //     //   ],
  //     // );
  //   }
  // }

  Future<List<Cart>> futureCart;

  @override
  void initState() {
    super.initState();
    futureCart = cp.fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text("Check Out",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
          )
        ]),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, top: 20),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Ordered Item:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: FutureBuilder<List<Cart>>(
                future: cp.fetchCart(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return cartListView(context, snapshot);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ))),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'Total :RM ${widget.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Address to be Delivered:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 3,
                  initialValue: cust.address,
                  decoration: textFieldDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your restaurant name';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                'Place Your Order',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Check Out"),
                      content: Text(
                          "Are you sure to check out? The process is irreversible."),
                      actions: [
                        FlatButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text("Yes"),
                          onPressed: () {
                            if (address == null) {
                              address = cust.address;
                            }
                            moveToOrder();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              color: Colors.orange,
              textColor: Colors.white,
            ),
          )
        ],
      ),
    ]));
  }

  Widget cartListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Cart> cart = snapshot.data;
    return Stack(children: <Widget>[
      Container(
          height: double.infinity,
          padding: EdgeInsets.only(bottom: 70),
          child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
              itemCount: snapshot.data.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 0,
                      color: Colors.black,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              cart[index].itemName,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${cart[index].quantity.toString()}',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'RM ${(cart[index].itemPrice * cart[index].quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        if (index == snapshot.data.length - 1) {
                          return Divider(
                            height: 0,
                            color: Colors.black,
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                );
              })),
    ]);
  }
}
