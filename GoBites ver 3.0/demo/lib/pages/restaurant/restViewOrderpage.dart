import 'dart:convert';
import 'package:demo/modules/orderItem.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';
import 'restHomepage.dart';

class RestaurantViewOrderPage extends StatefulWidget {
  @override
  _RestaurantViewOrderPageState createState() =>
      _RestaurantViewOrderPageState();
}

class _RestaurantViewOrderPageState extends State<RestaurantViewOrderPage> {
  Future<RestDetail> fetchRestDetail() async {
    final response = await http_get('/restaurant/' + login.login_id);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return RestDetail.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load detail, code = ' + response.statusCode.toString());
    }
  }

  List<OrderItem> parseOrderItem(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
  }

  Future<List<OrderItem>> fetchOrderItem(int rid) async {
    final response = await http_get('/vieworderrest/' + rid.toString());
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

  Future<List<OrderItem>> futureOrderList;
  Future<RestDetail> futureRestDetail;
  RestDetail rest;
  @override
  void initState() {
    super.initState();
    futureRestDetail = fetchRestDetail();
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
        title: Text('Order List'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          child: FutureBuilder<RestDetail>(
              future: futureRestDetail,
              builder: (context, snapshot1) {
                if (snapshot1.hasData) {
                  rest = snapshot1.data;
                  print(rest.RID);
                  return FutureBuilder<List<OrderItem>>(
                      future: fetchOrderItem(snapshot1.data.RID),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return orderListView(context, snapshot);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error);
                        }
                        return Center(child: CircularProgressIndicator());
                      });
                } else if (snapshot1.hasError) {
                  return Text(snapshot1.error);
                }
                return Center(child: CircularProgressIndicator());
              })),
    );
  }

  Widget orderListView(BuildContext context, AsyncSnapshot snapshot) {
    List<OrderItem> orders = snapshot.data;
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
                          orders[index].itemName,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${orders[index].quantity.toString()}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'RM ${(orders[index].itemPrice * orders[index].quantity).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.remove),
                          color: Colors.black,
                          onPressed: () {
                            print(orders[index].ID);
                            removeAlertDialog(context, orders[index].ID);
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
