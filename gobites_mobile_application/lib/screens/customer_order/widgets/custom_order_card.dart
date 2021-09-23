import 'package:flutter/material.dart';
import 'package:gobites/models/order.dart';
import 'package:intl/intl.dart';

Card customOrderCard({Order order}) {
  return Card(
    elevation: 4.0,
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text("Order ID: ${order.oid.toString()}",
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
              Expanded(
                  flex: 6,
                  child: Text(
                    "${DateFormat('dd-MM-yyyy hh:mm aa').format(order.addedDate)}",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.end,
                  )),
            ],
          ),
        ),
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
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
            itemCount: order.orderItemList.length,
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
                            order.orderItemList[index].itemName,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${order.orderItemList[index].quantity.toString()}',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'RM ${(order.orderItemList[index].itemPrice * order.orderItemList[index].quantity).toStringAsFixed(2)}',
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
                      'RM ${order.totalPrice.toStringAsFixed(2)}',
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
                        '${order.address}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      )),
                ]))),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(5.0),
          child: Text("${order.status}",
              style: TextStyle(fontSize: 18, color: getColor(order.status)),
              textAlign: TextAlign.right),
        ),
      ],
    ),
  );
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