import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/cart.dart';
import 'package:gobites/screens/customer_cart/customer_cart_viewmodel.dart';
import 'package:gobites/screens/view.dart';

class CustomerOrderComplete extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => CustomerOrderComplete());
  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<CustomerCartViewmodel>(),
        builder: (context, viewmodel, _) {
          return Scaffold(
              body: Card(
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
                                child: orderListView(context, viewmodel)),
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
                                        "RM ${viewmodel.totalPrice.toStringAsFixed(2)}",
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
                                        "${viewmodel.deliveryAddress}",
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
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                  },
                                  color: Colors.orange,
                                  textColor: Colors.white,
                                ),
                              ),
                            ])
                      ],
                    ),
                  )));
        });
  }

  Widget orderListView(BuildContext context, CustomerCartViewmodel viewmodel) {
    List<Cart> orderitem = viewmodel.cartList;
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
        itemCount: orderitem.length,
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
