import 'dart:convert';
import 'package:demo/modules/orderItem.dart';
import 'package:demo/modules/orders.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'restHomepage.dart';
import 'restOrderItem.dart';

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

    print('item parsed');
    return parsed.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
  }

  Future<List<OrderItem>> fetchOrderItem(int oid) async {
    print(oid);
    final response = await http_get('/vieworderitemrest/' + oid.toString());
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
  //Future<List<OrderItem>> fetchOrderItem(int rid) async {
  //final response = await http_get('/vieworderidrest/' + rid.toString());
  //if (response.statusCode == 200) {
  //// If the server did return a 200 OK response,
  //// then parse the JSON.
  //return parseOrderItem(response.body);
  //} else {
  //// If the server did not return a 200 OK response,
  //// then throw an exception.
  //throw Exception(
  //'Failed to load, code = ' + response.statusCode.toString());
  //}
  //}

  List<Orders> parseOrder(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Orders>((json) => Orders.fromJson(json)).toList();
  }

  //Future<List<Orders>> fetchOrder(int rid) async {
  //final response = await http_get('/vieworderrest/' + rid.toString());
  //if (response.statusCode == 200) {
  //// If the server did return a 200 OK response,
  //// then parse the JSON.
  //return parseOrder(response.body);
  //} else {
  //// If the server did not return a 200 OK response,
  //// then throw an exception.
  //throw Exception(
  //'Failed to load, code = ' + response.statusCode.toString());
  //}
  //}

  Future<List<Orders>> fetchOrderDate(int rid) async {
    final response = await http_get('/vieworderdate/' + rid.toString());
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

  Future<List<OrderItem>> futureOrderItem;
  Future<List<Orders>> futureOrderDate;
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
      /*appBar: AppBar(
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
        backgroundColor: Colors.blue,
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          child: FutureBuilder<RestDetail>(
              future: futureRestDetail,
              builder: (context, snapshot1) {
                if (snapshot1.hasData) {
                  rest = snapshot1.data;
                  print(rest.RID);
                  return FutureBuilder<List<Orders>>(
                      future: fetchOrderDate(snapshot1.data.RID),
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
              })),*/
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
                          builder: (BuildContext context) =>
                              new RestHomePage()),
                      (route) => false),
                  icon: Icon(Icons.arrow_back, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Order List",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30))),
            )
          ]),
        ),
        Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: FutureBuilder<RestDetail>(
                    future: futureRestDetail,
                    builder: (context, snapshot1) {
                      if (snapshot1.hasData) {
                        rest = snapshot1.data;
                        print(rest.RID);
                        return FutureBuilder<List<Orders>>(
                            future: fetchOrderDate(snapshot1.data.RID),
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
                    }))),
      ]),
    );
  }

  Widget orderListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Orders> orderDate = snapshot.data;
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
                        flex: 1,
                        child: Text(
                          "Order: ${index + 1}",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Date: ${DateFormat('dd-MM-yyyy hh:mm aa').format(orderDate[index].addedDate)}",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'RM ${(orderDate[index].totalPrice.toStringAsFixed(2))}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.add_alert),
                          color: Colors.black,
                          onPressed: () {
                            //FutureBuilder<List<OrderItem>>(
                            //future: fetchOrderItem(orderDate[index].OID),
                            //builder: (context, snapshot) {
                            //print('print');
                            //if (snapshot.hasData) {
                            //print('printing list');
                            //return orderItemView(context, snapshot);
                            //} else if (snapshot.hasError) {
                            //return Text(snapshot.error);
                            //}
                            //return Center(
                            //child: CircularProgressIndicator());
                            //});
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new RestOrderItemPage(
                                            orderID: orderDate[index].OID)));
                          },
                        ),
                      ),
                      //Expanded(
                      //flex: 1,
                      //child: IconButton(
                      //icon: Icon(Icons.check),
                      //color: Colors.black,
                      //onPressed: () {
                      //print(orders[index].ID);
                      //orderComplete(orders[index].ID);
                      //},
                      //),
                      //),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
