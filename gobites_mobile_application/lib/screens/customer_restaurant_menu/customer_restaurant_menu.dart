import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/menu.dart';
import 'package:gobites/models/restaurant.dart';
import 'package:gobites/screens/customer_restaurant_menu/customer_restaurant_menu_viewmodel.dart';
import 'package:gobites/screens/view.dart';

class CustomerRestaurantMenu extends StatelessWidget {
  static route(args) =>
      MaterialPageRoute(builder: (context) => CustomerRestaurantMenu(args));

  final Restaurant restaurant;
  CustomerRestaurantMenu(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<CustomerRestaurantMenuViewmodel>()
          ..init(restaurant),
        builder: (context, viewmodel, _) {
          CustomerRestaurantMenuViewmodel _viewmodel = viewmodel;
          return Scaffold(
              body: Column(children: [
            Stack(children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(top: 50, left: 20),
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.orange,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back, color: Colors.white)),
                      ))),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.only(top: 55, left: 20, right: 20),
                      child: Text("Menu Page",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)))),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: EdgeInsets.only(top: 50, right: 20),
                      child: IconButton(
                        icon: new Stack(
                          children: <Widget>[
                            new Icon(
                              Icons.shopping_cart_rounded,
                              size: 30,
                            ),
                            new Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: Text(
                                  '0',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/cust_cart');
                        },
                      )))
            ]),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                      itemCount: _viewmodel.menuList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => menuCard(
                          _viewmodel.menuList[index], context, viewmodel))),
            )
          ]));
        });
  }

  Widget menuCard(Menu menu, BuildContext context, _viewmodel) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          MaterialButton(
            onPressed: () {},
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 5,
                    child: Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          menu.name,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('RM ${menu.price.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 18))),
                    ])),
                Expanded(
                  flex: 1,
                  child: IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.black,
                      onPressed: () {
                        int quantity = 1;
                        return showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) =>
                                new StatefulBuilder(
                                    builder: (context, setState) {
                                  return AlertDialog(
                                    title: Text("Add to Cart"),
                                    content: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Name: ${menu.name}\n"),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                "Price: RM${menu.price.toStringAsFixed(2)}\n"),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text("Quantity: "),
                                              new IconButton(
                                                icon: Icon(Icons.remove),
                                                color: Colors.black,
                                                onPressed: () => setState(() {
                                                  if (quantity > 1) {
                                                    quantity--;
                                                  }
                                                }),
                                              ),
                                              new Text('$quantity'),
                                              new IconButton(
                                                icon: Icon(Icons.add),
                                                color: Colors.black,
                                                onPressed: () =>
                                                    setState(() => quantity++),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          child: Text('Continue'),
                                          onPressed: () {
                                            _viewmodel.addToCart(
                                                menu.mid, quantity);
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Item(s) is/are successfully added to the cart.')));
                                          }),
                                      TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                    ],
                                  );
                                }));
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
