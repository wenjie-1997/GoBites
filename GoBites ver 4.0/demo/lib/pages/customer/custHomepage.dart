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
import 'package:demo/modules/local_notification.dart';

CustDetail cust;

//void callbackDispatcher1() {
//Workmanager.executeTask((taskName, inputData) async {
////show notification
//LocalNotification.Initializer();
//var response = await http_get('/vieworderstatus/' + login.login_id);
//print(response);
//var convert = json.decode(response.body);
//if (convert['status'] == "DELIVERING") {
//LocalNotification.DeliveryNotification(DateTime.now());
//} else if (convert['status'] == "DONE") {
//LocalNotification.DeliveredNotification(DateTime.now());
//} else {
//print("no message");
//}
//return Future.value(true);
//});
//}

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

notification() async {
  var response = await http_get('/vieworderstatus/' + login.login_id);
  if (response.statusCode == 200) {
    var convert = json.decode(response.body);
    if (convert['status'] == "DELIVERING") {
      LocalNotification.DeliveryNotification(DateTime.now());
    } else if (convert['status'] == "DONE") {
      LocalNotification.DeliveredNotification(DateTime.now());
    } else {
      print("no message");
    }
  }
}

class _CustHomePageState extends State<CustHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    LocalNotification.Initializer();
    notification();
    //WidgetsFlutterBinding.ensureInitialized();
    //Workmanager.initialize(callbackDispatcher1);
    //Workmanager.registerPeriodicTask("test_workertask1", "test_workertask1",
    //frequency: Duration(minutes: 15),
    //initialDelay: Duration(seconds: 5),
    //inputData: {"data1": "value1", "data2": "value2"});
    fetchCustDetail();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final orderButton = FlatButton(
        height: 80.0,
        color: Colors.orange,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustRestaurantPage()));
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

    // final personalDetailButton = Material(
    //     elevation: 5.0,
    //     color: Colors.blue,
    //     child: MaterialButton(
    //       height: 100.0,
    //       minWidth: SizeConfig.safeBlockVertical * 38,
    //       padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //       onPressed: () {
    //         Navigator.push(context,
    //             MaterialPageRoute(builder: (context) => PersonalInfoPage()));
    //       },
    //       child: Column(
    //         children: <Widget>[
    //           Icon(Icons.person),
    //           SizedBox(height: 10.0),
    //           Text(
    //             "Personal Detail",
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //                 color: Colors.white, fontSize: 20.0, letterSpacing: 3.0),
    //           ),
    //         ],
    //       ),
    //     ));

    final viewOrderButton = FlatButton(
        height: 80.0,
        color: Colors.orange,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustomerViewOrderPage()));
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
            ),
          )
        ]));

    final giveFeedbackButton = FlatButton(
        height: 80.0,
        color: Colors.orange,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomerOrderRatingPage()));
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
            ),
          )
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
                            'Welcome to GoBites, ${cust.custname.split(' ')[0]}.',
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
                            )))
                  ])),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      orderButton,
                      SizedBox(height: SizeConfig.safeBlockVertical * 3),
                      viewOrderButton,
                      SizedBox(height: SizeConfig.safeBlockVertical * 3),
                      giveFeedbackButton,
                      SizedBox(height: SizeConfig.safeBlockVertical * 3),
                    ],
                  ))
            ],
          )),
    );

    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    List<Widget> _widgetOptions = <Widget>[mainPage, PersonalInfoPage()];

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
