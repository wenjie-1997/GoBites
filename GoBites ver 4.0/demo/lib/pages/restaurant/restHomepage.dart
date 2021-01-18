import 'dart:convert';

import 'package:demo/modules/http.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/pages/restaurant/restRatingpage.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/restaurant/restMenupage.dart';
import 'package:demo/pages/restaurant/restaurantInfo.dart';
import 'package:demo/pages/restaurant/restViewOrderpage.dart';
import 'package:demo/pages/pageSizing.dart';
import 'package:demo/pages/login.dart' as login;

RestDetail rest;

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

fetchRestDetail() async {
  final response = await http_get('/restaurant/' + login.login_id);

  if (response.statusCode == 200) {
    rest = RestDetail.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load album, code = ' + response.statusCode.toString());
  }
}

class _RestHomePageState extends State<RestHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  void initState() {
    super.initState();
    fetchRestDetail();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final menuButton = FlatButton(
        height: 80.0,
        color: Colors.orange,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RestMenuPage()));
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

    /*final restaurantDetailButton = Material(
        elevation: 5.0,
        color: Colors.blue,
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
                    color: Colors.white, fontSize: 20.0, letterSpacing: 3.0),
              ),
            ],
          ),
        ));*/

    final viewOrderButton = FlatButton(
        height: 80.0,
        color: Colors.orange,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RestaurantViewOrderPage()));
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

    final feedbackButton = FlatButton(
        height: 80.0,
        color: Colors.orange,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RestaurantRatingPage()));
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

    final mainPage = Center(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          height: SizeConfig.safeBlockVertical * 100,
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: Column(children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Welcome to GoBites, ${rest.restaurantname.split(' ')[0]}.',
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
                            )))
                  ])),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      menuButton,
                      SizedBox(height: SizeConfig.safeBlockVertical * 3),
                      viewOrderButton,
                      SizedBox(height: SizeConfig.safeBlockVertical * 3),
                      feedbackButton,
                      SizedBox(height: SizeConfig.safeBlockVertical * 3),
                    ],
                  ))
            ],
          )),
    );

    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    List<Widget> _widgetOptions = <Widget>[mainPage, RestaurantPersonalInfoPage()];

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
        );
  }
}
