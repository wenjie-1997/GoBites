import 'dart:convert';
import 'package:demo/modules/orderItem.dart';
import 'package:demo/modules/orders.dart';
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custHomepage.dart';

Orders orders;

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
      body: FutureBuilder<Orders>(
          future: futureOrder,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              orders = snapshot.data;
              return Card(
                  elevation: 5,
                  margin:
                      EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10.0),
                    child: Stack(
                      children: <Widget>[
                        ListView(
                          children: <Widget>[
                            Text(
                              "Order Successful!",
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Order ID: ${orders.OID.toString()}",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "${DateFormat('dd-MM-yyyy hh:mm aa').format(orders.addedDate)}",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Ordered Item(s):",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Container(
                              height: 220,
                              child: FutureBuilder(
                                  future: futureOrderList,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return orderListView(context, snapshot);
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error);
                                    }
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        "Total Price",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  Expanded(
                                      flex: 9,
                                      child: Text(
                                        "RM ${orders.totalPrice.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Address",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 9,
                                      child: Text(
                                        "${orders.address}",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                width: double.infinity,
                                child: RaisedButton(
                                  child: Text(
                                    'Continue',
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustHomePage()),
                                        (route) => false);
                                  },
                                  color: Colors.orange,
                                  textColor: Colors.white,
                                ),
                              ),
                            ])
                      ],
                    ),
                  ));
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
