import 'dart:convert';
import 'package:demo/modules/orderItem.dart';
import 'package:demo/modules/orders.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/http.dart';
import 'package:demo/pages/registration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'restHomepage.dart';
import 'restViewOrderpage.dart';

class RestOrderItemPage extends StatefulWidget {
  final int orderID;
  RestOrderItemPage({Key key, @required this.orderID}) : super(key: key);

  @override
  _RestOrderItemPageState createState() => _RestOrderItemPageState();
}

class _RestOrderItemPageState extends State<RestOrderItemPage> {
  List<OrderItem> parseOrderItem(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
  }

  Future<List<OrderItem>> fetchOrderItem() async {
    final response =
        await http_get('/vieworderitemrest/' + widget.orderID.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseOrderItem(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load, code = ' + response.statusCode.toString());
    }
  }

  Future orderSetComplete(int oid) async {
    final msg = jsonEncode({
      "OID": oid,
    });

    final response = await http_post("/ordersetstatus", msg);
    String status = jsonDecode(response.body);

    if (status == "orders status done") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Order set is ready for delivery!"),
                actions: <Widget>[
                  TextButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new RestaurantViewOrderPage()));
                    },
                  )
                ],
              ));
    }
  }

  Future orderComplete(int id) async {
    final msg = jsonEncode({
      "ID": id,
    });
    final response = await http_post("/orderitemstatus", msg);
    String status = jsonDecode(response.body);

    if (status == "orderitem status done") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Order is successfully completed."),
                actions: <Widget>[
                  TextButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new RestOrderItemPage(
                                    orderID: widget.orderID,
                                  )));
                    },
                  )
                ],
              ));
    }
  }

  Future orderitemDelete(int id) async {
    final msg = jsonEncode({
      "ID": id,
    });
    final result = await http_post("/orderitemdelete", msg);
    String status = jsonDecode(result.body);
    //String status = loginResult.getStatus();
    if (status == "Delete Order Sucessful") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Delete Order Successful"),
                actions: <Widget>[
                  TextButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new RestaurantViewOrderPage()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new RestHomePage()),
              (route) => false),
        ),
        title: Text('Order Items'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          child: FutureBuilder<List<OrderItem>>(
              future: fetchOrderItem(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FutureBuilder<List<OrderItem>>(
                      future: fetchOrderItem(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return orderItemView(context, snapshot);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error);
                        }
                        return Center(child: CircularProgressIndicator());
                      });
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                }
                return Center(child: CircularProgressIndicator());
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          orderSetComplete(widget.orderID);
        },
        child: Icon(Icons.check),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        mini: false,
        highlightElevation: 20.0,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
      ),
    );
  }

  Widget orderItemView(BuildContext context, AsyncSnapshot snapshot) {
    List<OrderItem> orderItem = snapshot.data;
    return ListView.builder(
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
                        child: Text(
                          orderItem[index].itemName,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          orderItem[index].quantity.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'RM ${(orderItem[index].itemPrice.toStringAsFixed(2))}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.black,
                          onPressed: () {
                            orderitemDelete(orderItem[index].ID);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.check),
                          color: Colors.black,
                          onPressed: () {
                            orderComplete(orderItem[index].ID);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  removeAlertDialog(BuildContext context, int id) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        orderitemDelete(id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Remove Order"),
      content: Text("Are you sure to remove this order?"),
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
