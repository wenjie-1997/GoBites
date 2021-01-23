import 'dart:convert';
import 'dart:ui';
import 'package:demo/modules/orderItem.dart';
import 'package:demo/modules/orders.dart';
import 'package:demo/modules/custdetail.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custHomepage.dart';

class CustomerViewOrderPage extends StatefulWidget {
  @override
  _CustomerViewOrderPageState createState() => _CustomerViewOrderPageState();
}

class _CustomerViewOrderPageState extends State<CustomerViewOrderPage> {
  Future<CustDetail> fetchCustDetail() async {
    final response = await http_get('/customer/' + login.login_id);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return CustDetail.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load album, code = ' + response.statusCode.toString());
    }
  }

  List<Orders> parseOrderId(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Orders>((json) => Orders.fromJson(json)).toList();
  }

  Future<List<Orders>> fetchOrderId(int cid) async {
    print(cid);
    final response = await http_get('/vieworderidcust/' + cid.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseOrderId(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load, code = ' + response.statusCode.toString());
    }
  }

  List<OrderItem> parseOrder(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
  }

  Future<List<OrderItem>> fetchOrder(int oid) async {
    final response = await http_get('/viewordername/' + oid.toString());
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

  Future<List<Orders>> futureOrderIdList;
  Future<CustDetail> futureCustDetail;
  CustDetail cust;
  @override
  void initState() {
    super.initState();
    futureCustDetail = fetchCustDetail();
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
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new CustHomePage()),
                    (route) => false),
                icon: Icon(Icons.arrow_back, color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text("Order List",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
          )
        ]),
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: FutureBuilder<CustDetail>(
                  future: futureCustDetail,
                  builder: (context, snapshot1) {
                    if (snapshot1.hasData) {
                      return FutureBuilder<List<Orders>>(
                          future: fetchOrderId(snapshot1.data.CID),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return orderIdListView(context, snapshot);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return Center(child: CircularProgressIndicator());
                          });
                    } else if (snapshot1.hasError) {
                      return Text(snapshot1.error);
                    }
                    return Center(child: CircularProgressIndicator());
                  }))),
    ]));
  }

  Widget orderIdListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Orders> orders = snapshot.data;
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        itemCount: snapshot.data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
              margin: EdgeInsets.only(bottom: 20),
              elevation: 4.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(5.0),
                        child: Row(children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Text(
                                "Order ID: ${orders[index].OID.toString()}",
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ),
                          Expanded(
                              flex: 6,
                              child: Text(
                                "${DateFormat('dd-MM-yyyy hh:mm aa').format(orders[index].addedDate)}",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.end,
                              )),
                        ])),
                    Container(
                        padding: EdgeInsets.all(5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ordered Item(s):',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                    Divider(
                      color: Colors.black,
                    ),
                    FutureBuilder<List<OrderItem>>(
                        future: fetchOrder(orders[index].OID),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return orderListView(context, snapshot);
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error);
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
                    Container(
                        padding: EdgeInsets.all(5.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Price:  ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: Text(
                                  'RM ${orders[index].totalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              )
                            ]))),
                    Container(
                        padding: EdgeInsets.all(5.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Address: ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 10,
                                  child: Text(
                                    '${orders[index].address}',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.start,
                                  )),
                            ]))),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(5.0),
                      child: Text("${orders[index].status}",
                          style: TextStyle(
                              fontSize: 18,
                              color: getColor(orders[index].status)),
                          textAlign: TextAlign.right),
                    ),
                  ],
                ),
              ));
        });
  }

  Widget orderListView(BuildContext context, AsyncSnapshot snapshot) {
    List<OrderItem> orderitem = snapshot.data;
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
        itemCount: snapshot.data.length,
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

getColor(String status) {
  if (status == "PREPARING") {
    return Colors.yellow[800];
  } else if (status == "DELIVERING") {
    return Colors.lightBlue[400];
  } else {
    return Colors.black54;
  }
}
