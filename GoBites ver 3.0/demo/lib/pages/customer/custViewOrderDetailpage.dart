import 'dart:convert';
import 'package:demo/modules/orderItem.dart';
import 'package:demo/modules/orders.dart';
import 'package:demo/modules/custdetail.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';
import 'custViewOrderpage.dart';

class CustomerViewOrderDetailPage extends StatefulWidget {
  final Orders order;
  CustomerViewOrderDetailPage({Key key, @required this.order})
      : super(key: key);
  @override
  _CustomerViewOrderDetailPageState createState() =>
      _CustomerViewOrderDetailPageState();
}

class _CustomerViewOrderDetailPageState
    extends State<CustomerViewOrderDetailPage> {
  List<OrderItem> parseOrder(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
  }

  Future<List<OrderItem>> fetchOrder() async {
    final response =
        await http_get('/viewordername/' + widget.order.OID.toString());
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

  Future<Orders> futureOrder;
  Future<List<OrderItem>> futureOrderList;

  @override
  void initState() {
    super.initState();
    futureOrderList = fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Order Detail'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Order ID: ${widget.order.toString()}",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
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
                "Total Price: RM ${widget.order.totalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Status: ${widget.order.status}",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
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
