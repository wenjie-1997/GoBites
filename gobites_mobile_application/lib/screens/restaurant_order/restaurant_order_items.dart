import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/order.dart';
import 'package:gobites/models/order_item.dart';
import 'package:gobites/screens/restaurant_order/restaurant_order_viewmodel.dart';
import 'package:gobites/screens/view.dart';

class RestaurantOrderItems extends StatelessWidget {
  static route(args) =>
      MaterialPageRoute(builder: (context) => RestaurantOrderItems(args));

  final Order order;
  RestaurantOrderItems(this.order);

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<RestaurantOrderViewmodel>()..initForOrderItem(order),
        builder: (context, viewmodel, _) {
          RestaurantOrderViewmodel _viewmodel = viewmodel;
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
                        child: Text("Order Items",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30))),
                  )
                ]),
              ),
              Expanded(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: ListView.builder(
                          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                          itemCount: _viewmodel.selectedOrder.orderItemList.length,
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
                                            _viewmodel.selectedOrder.orderItemList[index].itemName,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Text(
                                              _viewmodel.selectedOrder
                                                  .orderItemList[index].quantity
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'RM ${(_viewmodel.selectedOrder.orderItemList[index].itemPrice.toStringAsFixed(2))}',
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
                                              removeAlertDialog(context,
                                                  () async {
                                                     Navigator.pop(context);
                                                await _viewmodel
                                                    .removeOrderItem(
                                                        _viewmodel.selectedOrder,
                                                        order.orderItemList[
                                                            index]);
                                               
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            icon: Icon(Icons.check),
                                            color: Colors.black,
                                            onPressed: () async {
                                              await _viewmodel
                                                  .changeOrderItemStatus(
                                                      _viewmodel.selectedOrder,
                                                      order.orderItemList[
                                                          index]);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          })))
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (_viewmodel.selectedOrder.orderItemList.isNotEmpty) return null;
                await _viewmodel.completeOrder(order.oid);
                Navigator.pop(context);
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
        });
  }

  removeAlertDialog(BuildContext context, Function onDelete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = TextButton(child: Text("Yes"), onPressed: onDelete);

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
