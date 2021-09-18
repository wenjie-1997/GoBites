import 'package:flutter/material.dart';
import 'package:gobites/models/order.dart';
import 'package:intl/intl.dart';

Card customOrderCard({Order order, Function onPressed}) {
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
                flex: 7,
                child: Text(
                  "Date: ${DateFormat('dd-MM-yyyy hh:mm aa').format(order.addedDate)}\n" +
                      "RM ${(order.totalPrice.toStringAsFixed(2))}",
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
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
