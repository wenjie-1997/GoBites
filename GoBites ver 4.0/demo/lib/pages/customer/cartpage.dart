import 'dart:convert';
import 'dart:ui';
import 'package:demo/modules/cart.dart';
import 'package:demo/modules/custdetail.dart';
import 'package:demo/modules/orders.dart';
import 'package:demo/pages/customer/checkoutpage.dart';
import 'package:demo/pages/customer/orderConfirmation.dart';
import 'package:flutter/material.dart';
import 'package:demo/modules/http.dart';
import 'custHomepage.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double _totalPrice;
  Future<CustDetail> futureCustDetail;
  bool _isButtonDisabled;

  moveToOrder() async {
    final msg = jsonEncode({
      "CID": cust.CID,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Checkoutpage(oid: orders.OID)));
                    },
                  )
                ],
              ));
    }
  }

  cartItemDelete(int kid) async {
    final msg = jsonEncode({
      /*"itemName": itemName,
      "itemPrice": itemPrice,
      "itemPhoto": "default.png",
      "itemDesc": itemDesc,*/
      "KID": kid,
    });
    final result = await http_post("/cartdelete", msg);
    String status = jsonDecode(result.body);
    //String status = loginResult.getStatus();
    if (status == "Delete Sucessful") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Delete Successful"),
                actions: <Widget>[
                  TextButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new CartPage()));
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

  List<Cart> parseCart(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
  }

  Future<List<Cart>> fetchCart() async {
    final response = await http_get('/viewcart/' + cust.CID.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseCart(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load, code = ' + response.statusCode.toString());
    }
  }

  @override
  void initState() {
    _isButtonDisabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //       icon: Icon(Icons.arrow_back, color: Colors.black),
        //       onPressed: () => Navigator.of(context).pop()),
        //   title: Text('My Cart'),
        //   centerTitle: true,
        //   backgroundColor: Colors.blue,
        // ),
        // body: FutureBuilder(
        //   future: fetchCart(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       _totalPrice = 0;
        //       List<Cart> carts = snapshot.data;
        //       for (var i = 0; i < carts.length; i++) {
        //         _totalPrice += (carts[i].itemPrice * carts[i].quantity);
        //       }
        //       return cartListView(context, snapshot);
        //     } else if (snapshot.hasError) {
        //       return Text(snapshot.error);
        //     }
        //     return Center(child: CircularProgressIndicator());
        //   },
        // ));
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
                child: Text("My Cart",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
          )
        ]),
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: FutureBuilder<List<Cart>>(
                future: fetchCart(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _totalPrice = 0;
                    List<Cart> carts = snapshot.data;
                    for (var i = 0; i < carts.length; i++) {
                      _totalPrice += (carts[i].itemPrice * carts[i].quantity);
                    }
                    if (_totalPrice == 0) {
                      _isButtonDisabled = true;
                    }
                    return cartListView(context, snapshot);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ))),
    ]));
  }

  Widget cartListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Cart> carts = snapshot.data;
    return Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.only(bottom: 70),
          child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
              itemCount: snapshot.data.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/default.png'),
                                radius: 30.0,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(carts[index].itemName),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                  child:
                                      Text(carts[index].quantity.toString())),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                    'RM ${carts[index].itemPrice.toStringAsFixed(2)}'),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.black,
                                onPressed: () {
                                  deleteAlertDialog(context, carts[index].KID);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          padding: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          child: RaisedButton(
            child: Text(
              'Total (RM ${_totalPrice.toStringAsFixed(2)}) \n Check Out',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              if (_isButtonDisabled) {
                return null;
              }
              if (_totalPrice != 0) {
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
                            moveToOrder();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            color: Colors.orange,
            textColor: Colors.white,
          ),
        ),
      )
    ]);
  }

  deleteAlertDialog(BuildContext context, int id) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        cartItemDelete(id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Itm"),
      content: Text("Are you sure to delete this item?"),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
