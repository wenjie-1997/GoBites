import 'package:demo/pages/customer/custViewOrderpage.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/customer/custRestaurantpage.dart';
import 'package:demo/pages/customer/personalInfo.dart';
import 'package:demo/pages/pageSizing.dart';

class CustomerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Customer Home Page',
      home: CustHomePage(),
    );
  }
}

class CustHomePage extends StatefulWidget {
  @override
  _CustHomePageState createState() => _CustHomePageState();
}

class _CustHomePageState extends State<CustHomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final orderButton = Material(
        elevation: 5.0,
        color: Colors.red,
        child: MaterialButton(
          height: 100.0,
          minWidth: SizeConfig.safeBlockVertical * 38,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustRestaurantPage()));
          },
          child: Column(
            children: <Widget>[
              Icon(Icons.fastfood),
              SizedBox(height: 10.0),
              Text(
                "Order Food",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.amber, fontSize: 20.0, letterSpacing: 3.0),
              ),
            ],
          ),
        ));

    final personalDetailButton = Material(
        elevation: 5.0,
        color: Colors.red,
        child: MaterialButton(
          height: 100.0,
          minWidth: SizeConfig.safeBlockVertical * 38,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PersonalInfoPage()));
          },
          child: Column(
            children: <Widget>[
              Icon(Icons.person),
              SizedBox(height: 10.0),
              Text(
                "Personal Detail",
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
          minWidth: SizeConfig.safeBlockVertical * 38,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerViewOrderPage()));
          },
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

    final giveFeedbackButton = Material(
        elevation: 5.0,
        color: Colors.red,
        child: MaterialButton(
          height: 100.0,
          minWidth: SizeConfig.safeBlockVertical * 38,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          onPressed: () {},
          child: Column(
            children: <Widget>[
              Icon(Icons.feedback),
              SizedBox(height: 10.0),
              Text(
                "Give Feedback",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.amber, fontSize: 20.0, letterSpacing: 3.0),
              ),
            ],
          ),
        ));

    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                  orderButton,
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  personalDetailButton,
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  viewOrderButton,
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  giveFeedbackButton,
                ],
              ),
            ),
          ),
        ));
  }
}
