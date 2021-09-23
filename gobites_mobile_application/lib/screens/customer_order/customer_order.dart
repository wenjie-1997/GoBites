import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/order.dart';
import 'package:gobites/models/order_item.dart';
import 'package:gobites/screens/customer_order/customer_order_viewmodel.dart';
import 'package:gobites/screens/view.dart';
import 'package:intl/intl.dart';

class CustomerOrder extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => CustomerOrder());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<CustomerOrderViewmodel>()..init(),
        builder: (context, viewmodel, _) {
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
                    child: orderIdListView(context, viewmodel))),
          ]));
        });
  }

  Widget orderIdListView(
      BuildContext context, CustomerOrderViewmodel viewmodel) {
    List<Order> orders = viewmodel.orderList;
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        itemCount: orders.length,
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
                                "Order ID: ${orders[index].oid.toString()}",
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
                    orderItems(context, orders[index]),
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

  Widget orderItems(BuildContext context, Order order) {
    List<OrderItem> orderItems = order.orderItemList;
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
        itemCount: orderItems.length,
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
                        orderItems[index].itemName,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${orderItems[index].quantity.toString()}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'RM ${(orderItems[index].itemPrice * orderItems[index].quantity).toStringAsFixed(2)}',
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
