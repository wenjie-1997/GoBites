import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/screens/restaurant_order/restaurant_order_viewmodel.dart';
import 'package:gobites/screens/restaurant_order/widgets/custom_order_card.dart';
import 'package:gobites/screens/view.dart';

class RestaurantOrder extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => RestaurantOrder());
  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<RestaurantOrderViewmodel>()..init(),
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
                    child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                        itemCount: _viewmodel.orderList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return customOrderCard(
                              order: _viewmodel.orderList[index],
                              onPressed: () async {
                                await Navigator.pushNamed(
                                    context, '/rest_order_items',
                                    arguments: _viewmodel.orderList[index]);
                                await _viewmodel.init();
                              });
                        })))
          ]));
        });
  }
}
