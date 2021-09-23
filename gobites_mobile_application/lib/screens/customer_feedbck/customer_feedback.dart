import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/order.dart';
import 'package:gobites/models/order_item.dart';
import 'package:gobites/screens/customer_feedbck/customer_feedback_viewmodel.dart';
import 'package:gobites/screens/view.dart';
import 'package:intl/intl.dart';

class CustomerFeedback extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => CustomerFeedback());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<CustomerFeedbackViewmodel>()..init(),
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
                      child: Text("Feedback List",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30))),
                )
              ]),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: orderIdListView(context, viewmodel)),
            )
          ]));
        });
  }

  Widget orderIdListView(
      BuildContext context, CustomerFeedbackViewmodel viewmodel) {
    List<Order> orderList = viewmodel.orderList;
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        itemCount: orderList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
              margin: EdgeInsets.only(bottom: 20),
              elevation: 4.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  'Order ID: ${orderList[index].oid.toString()}'),
                            ),
                          ),
                          Text(
                            "${DateFormat('dd-MM-yyyy hh:mm aa').format(orderList[index].addedDate)}",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontStyle: FontStyle.italic),
                          )
                        ],
                      ),
                    ),
                    Container(
                        child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Ordered Item(s):'),
                    )),
                    Divider(
                      color: Colors.black,
                    ),
                    orderListView(context, orderList[index].orderItemList),
                    Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'Total Price: RM ${orderList[index].totalPrice.toStringAsFixed(2)}'),
                        )),
                    orderList[index].hasFeedback == 1
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(children: [
                                    Text("Rating        :  "),
                                    RatingBarIndicator(
                                      rating: orderList[index].rating,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 25,
                                      direction: Axis.horizontal,
                                    ),
                                  ])),
                              orderList[index].comment != null
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Comment  :\n${orderList[index].comment}",
                                      ),
                                    )
                                  : Container()
                            ]))
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: SizedBox(
                                height: 35,
                                width: 135,
                                child: Material(
                                    color: Colors.orange,
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/cust_give_feedback',
                                            arguments: orderList[index]);
                                      },
                                      child: Text(
                                        "Give Feedback",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      ),
                                    ))),
                          ),
                  ],
                ),
              ));
        });
  }

  Widget orderListView(BuildContext context, List<OrderItem> orderItemList) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        itemCount: orderItemList.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(orderItemList[index].itemName,
                            style: TextStyle(fontSize: 16)),
                        Text(
                          'RM ${(orderItemList[index].itemPrice * orderItemList[index].quantity).toStringAsFixed(2)}',
                        )
                      ],
                    ),
                    Text('${orderItemList[index].quantity.toString()}'),
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
