import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/cart.dart';
import 'package:gobites/screens/customer_cart/customer_cart_viewmodel.dart';
import 'package:gobites/screens/register/widget/custom_text_field.dart';
import 'package:gobites/screens/view.dart';

class CustomerCheckout extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => CustomerCheckout());
  // List<OrderItem> parseOrder(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  //   return parsed.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
  // }

  // moveToOrder() async {
  //   final msg = jsonEncode({
  //     "CID": cust.CID,
  //     "address": address,
  //   });
  //   final result = await http_post("/movetoorder", msg);
  //   Orders orders = Orders.fromJson(jsonDecode(result.body));
  //   //String status = loginResult.getStatus();
  //   if (orders.OID != null) {
  //     showDialog<void>(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) => AlertDialog(
  //               title: Text("Order Successful"),
  //               actions: <Widget>[
  //                 TextButton(
  //                   child: Text('Continue'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     Navigator.pushReplacement(
  //                         context,
  //                         MaterialPageRoute(
  //                             builder: (context) =>
  //                                 OrderConfirmPage(oid: orders.OID)));
  //                   },
  //                 )
  //               ],
  //             ));
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   futureCart = cp.fetchCart();
  // }

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<CustomerCartViewmodel>(),
        builder: (context, viewmodel, _) {
          CustomerCartViewmodel _viewmodel = viewmodel;
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
                      child: Text("Check Out",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30))),
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Ordered Item:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: cartListView(context, _viewmodel))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'Total :RM ${_viewmodel.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Address to be Delivered:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 3,
                        initialValue: _viewmodel.deliveryAddress,
                        decoration: textFieldDecoration(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your restaurant name';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          _viewmodel.deliveryAddress = value;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text(
                      'Place Your Order',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Check Out"),
                            content: Text(
                                "Are you sure to check out? The process is irreversible."),
                            actions: [
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text("Yes"),
                                onPressed: () {
                                  if (_viewmodel.deliveryAddress == '')
                                    _viewmodel.deliveryAddress =
                                        _viewmodel.customerAddress;
                                  _viewmodel.moveToOrder();
                                  Navigator.pushNamed(
                                      context, '/cust_order_complete');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    color: Colors.orange,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          ]));
        });
  }

  Widget cartListView(BuildContext context, CustomerCartViewmodel viewmodel) {
    return Stack(children: <Widget>[
      Container(
          height: double.infinity,
          padding: EdgeInsets.only(bottom: 70),
          child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
              itemCount: viewmodel.cartList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Cart cart = viewmodel.cartList[index];
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 0,
                      color: Colors.black,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              cart.itemName,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${cart.quantity.toString()}',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'RM ${(cart.itemPrice * cart.quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        if (index == viewmodel.cartList.length - 1) {
                          return Divider(
                            height: 0,
                            color: Colors.black,
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                );
              })),
    ]);
  }
}
