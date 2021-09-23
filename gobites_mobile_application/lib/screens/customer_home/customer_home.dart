import 'package:flutter/material.dart';

class CustomerHome extends StatelessWidget {
  orderButton(context) => FlatButton(
      height: 80.0,
      color: Colors.orange,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blueAccent,
      onPressed: () {
        Navigator.pushNamed(context, '/cust_restaurant_list');
      },
      child: Row(children: [
        Expanded(
            flex: 2,
            child: Icon(
              Icons.fastfood,
              size: 40,
            )),
        Expanded(
            flex: 6,
            child: Text(
              "Order Food",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0, letterSpacing: 3.0),
            )),
      ]));

  viewOrderButton(context) => FlatButton(
      height: 80.0,
      color: Colors.orange,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blueAccent,
      onPressed: () {
        Navigator.pushNamed(context, '/cust_order');
      },
      child: Row(children: [
        Expanded(
            flex: 2,
            child: Icon(
              Icons.list,
              size: 40,
            )),
        Expanded(
            flex: 6,
            child: Text(
              "View Order",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0, letterSpacing: 3.0),
            )),
      ]));

  giveFeedbackButton(context) => FlatButton(
      height: 80.0,
      color: Colors.orange,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blueAccent,
      onPressed: () {
        Navigator.pushNamed(context, '/cust_feedback');
      },
      child: Row(children: [
        Expanded(
            flex: 2,
            child: Icon(
              Icons.feedback,
              size: 40,
            )),
        Expanded(
            flex: 6,
            child: Text(
              "Give Feedback",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0, letterSpacing: 3.0),
            )),
      ]));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Welcome to GoBites',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Colors.black,
                  ))),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('\nOrder your food now!!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                    color: Colors.grey[800],
                  ))),
          Expanded(flex: 1, child: Container()),
          orderButton(context),
          SizedBox(height: 20),
          viewOrderButton(context),
          SizedBox(height: 20),
          giveFeedbackButton(context),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
