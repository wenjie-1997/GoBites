import 'dart:convert';
import 'package:demo/modules/custdetail.dart';
import 'package:demo/modules/http.dart';
import 'package:demo/pages/customer/custOrderRatingpage.dart';
import 'package:demo/pages/customer/custViewOrderpage.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/customer/custRestaurantpage.dart';
import 'package:demo/pages/customer/personalInfo.dart';
import 'package:demo/pages/pageSizing.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:demo/modules/local_notification.dart';

CustDetail cust;

void callbackDispatcher1() {
  Workmanager.executeTask((taskName, inputData) async {
    //show notification
    LocalNotification.Initializer();
    var response = await http_get('/vieworderstatus/' + login.login_id);
    print(response);
    var convert = json.decode(response.body);
    if (convert['status'] == "DELIVERING") {
      LocalNotification.DeliveryNotification(DateTime.now());
    } else if (convert['status'] == "DONE") {
      LocalNotification.DeliveredNotification(DateTime.now());
    } else {
      print("no message");
    }
    return Future.value(true);
  });
}

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

fetchCustDetail() async {
  final response = await http_get('/customer/' + login.login_id);

  if (response.statusCode == 200) {
    cust = CustDetail.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load album, code = ' + response.statusCode.toString());
  }
}

class _CustHomePageState extends State<CustHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Workmanager.initialize(callbackDispatcher1);
    Workmanager.registerPeriodicTask("test_workertask1", "test_workertask1",
        frequency: Duration(minutes: 15),
        initialDelay: Duration(seconds: 5),
        inputData: {"data1": "value1", "data2": "value2"});
    fetchCustDetail();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final orderButton = Material(
        elevation: 5.0,
        color: Colors.blue,
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
                    color: Colors.white, fontSize: 20.0, letterSpacing: 3.0),
              ),
            ],
          ),
        ));

    final personalDetailButton = Material(
        elevation: 5.0,
        color: Colors.blue,
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
                    color: Colors.white, fontSize: 20.0, letterSpacing: 3.0),
              ),
            ],
          ),
        ));

    final viewOrderButton = Material(
        elevation: 5.0,
        color: Colors.blue,
        child: MaterialButton(
          height: 100.0,
          minWidth: SizeConfig.safeBlockVertical * 38,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerViewOrderPage()));
          },
          child: Column(
            children: <Widget>[
              Icon(Icons.list),
              SizedBox(height: 10.0),
              Text(
                "View Order",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 20.0, letterSpacing: 3.0),
              ),
            ],
          ),
        ));

    final giveFeedbackButton = Material(
        elevation: 5.0,
        color: Colors.blue,
        child: MaterialButton(
          height: 100.0,
          minWidth: SizeConfig.safeBlockVertical * 38,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerOrderRatingPage()));
          },
          child: Column(
            children: <Widget>[
              Icon(Icons.feedback),
              SizedBox(height: 10.0),
              Text(
                "Give Feedback",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 20.0, letterSpacing: 3.0),
              ),
            ],
          ),
        ));

    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
