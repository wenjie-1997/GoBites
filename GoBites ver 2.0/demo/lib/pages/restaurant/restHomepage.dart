import 'package:flutter/material.dart';
import 'package:demo/pages/restaurant/restMenupage.dart';
import 'package:demo/pages/restaurant/restaurantInfo.dart';
import 'package:demo/pages/pageSizing.dart';

class RestaurantHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Restaurant Owner Home Page',
      home: RestHomePage(),
    );
  }
}

class RestHomePage extends StatefulWidget {
  @override
  _RestHomePageState createState() => _RestHomePageState();
}

class _RestHomePageState extends State<RestHomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final menuButton = Material(
        elevation: 5.0,
        color: Colors.red,
        child: MaterialButton(
          height: 100.0,
          minWidth: 250.0,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RestMenuPage()));
          },
          child: Column(
            children: <Widget>[
              Icon(Icons.restaurant_menu),
              SizedBox(height: 10.0),
              Text(
                "Menu List",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.amber, fontSize: 20.0, letterSpacing: 3.0),
              ),
            ],
          ),
        ));

    final restaurantDetailButton = Material(
        elevation: 5.0,
        color: Colors.red,
        child: MaterialButton(
          height: 100.0,
          minWidth: 250.0,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RestaurantPersonalInfoPage()));
          },
          child: Column(
            children: <Widget>[
              Icon(Icons.storefront),
              SizedBox(height: 10.0),
              Text(
                "Restaurant Detail",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.amber, fontSize: 20.0, letterSpacing: 3.0),
              ),
            ],
          ),
        ));

    final viewOrderButton = Material(
        elevation: 5.0,
        color: Colors.red,
        child: MaterialButton(
          height: 100.0,
          minWidth: 250.0,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          onPressed: () {},
          child: Column(
            children: <Widget>[
              Icon(Icons.list),
              SizedBox(height: 10.0),
              Text(
                "View Order",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.amber, fontSize: 20.0, letterSpacing: 3.0),
              ),
            ],
          ),
        ));

    final feedbackButton = Material(
        elevation: 5.0,
        color: Colors.red,
        child: MaterialButton(
          height: 100.0,
          minWidth: 250.0,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          onPressed: () {},
          child: Column(
            children: <Widget>[
              Icon(Icons.feedback),
              SizedBox(height: 10.0),
              Text(
                "My Feedback",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.amber, fontSize: 20.0, letterSpacing: 3.0),
              ),
            ],
          ),
        ));

    return Scaffold(
        backgroundColor: Colors.yellow[200],
        body: Center(
          child: Container(
            height: SizeConfig.safeBlockVertical * 100,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 10.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('GoBites',
                        style: TextStyle(
                            fontSize: 50.0,
                            letterSpacing: 3.0,
                            color: Colors.black,
                            fontFamily: 'Vibur')),
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  menuButton,
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  restaurantDetailButton,
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  viewOrderButton,
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  feedbackButton,
                ],
              ),
            ),
          ),
        ));
  }
}
