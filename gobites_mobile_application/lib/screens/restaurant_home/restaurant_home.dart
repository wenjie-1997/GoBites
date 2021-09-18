import 'package:flutter/material.dart';

class RestaurantHome extends StatelessWidget {
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
              child: Text('\nManage your restaurant now!!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                    color: Colors.grey[800],
                  ))),
          Expanded(flex: 1, child: Container()),
          menuButton(context),
          SizedBox(height: 20),
          viewOrderButton(context),
          SizedBox(height: 20),
          feedbackButton(context),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  FlatButton menuButton(BuildContext context) {
    return FlatButton(
        height: 80.0,
        color: Colors.orange,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
        onPressed: () {
          Navigator.pushNamed(context, '/rest_menu');
        },
        child: Row(children: [
          Expanded(
              flex: 2,
              child: Icon(
                Icons.restaurant_menu,
                size: 40,
              )),
          Expanded(
              flex: 6,
              child: Text(
                "Menu List",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 20.0, letterSpacing: 3.0),
              )),
        ]));
  }

  FlatButton viewOrderButton(BuildContext context) => FlatButton(
      height: 80.0,
      color: Colors.orange,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blueAccent,
      onPressed: () {
        Navigator.pushNamed(context, '/rest_order');
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

  FlatButton feedbackButton(context) => FlatButton(
      height: 80.0,
      color: Colors.orange,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.blueAccent,
      onPressed: () {
        Navigator.pushNamed(context, '/rest_feedback');
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
              "My Feedback",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0, letterSpacing: 3.0),
            )),
      ]));
}
