import 'dart:convert';
import 'custRestaurantpage.dart' as custrest;
import 'package:flutter/material.dart';
import 'package:demo/modules/http.dart';
import 'package:demo/modules/restdetail.dart';

Future<CustRestDetail> fetchRestDetail(String rid) async {
  final response = await http_get('/restaurants/' + rid);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("success");
    return CustRestDetail.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load, code = ' + response.statusCode.toString());
  }
}

class CustMenuPage extends StatefulWidget {
  final RestList rest;
  CustMenuPage({Key key, @required this.rest}) : super(key: key);
  @override
  _CustMenuPageState createState() => _CustMenuPageState();
}

class _CustMenuPageState extends State<CustMenuPage> {
  Future<CustRestDetail> futureCustRestDetail;

  @override
  void initState() {
    super.initState();
    futureCustRestDetail = fetchRestDetail(this.widget.rest.RID.toString());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
            backgroundColor: Colors.yellow[200],
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('Make an Order'),
              centerTitle: true,
              backgroundColor: Colors.red,
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                  child: FutureBuilder<CustRestDetail>(
                      future: futureCustRestDetail,
                      builder: (content, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                  child: Text(
                                    snapshot.data.restaurantname,
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  'Address',
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  snapshot.data.address,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  'Restaurant style',
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  snapshot.data.restaurantstyle,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5.0,
                                // ),
                                // Text(
                                //   '9am to 9pm',
                                //   style: TextStyle(
                                //     fontSize: 20.0,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  'Contact Us',
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.phone),
                                    Text(
                                      snapshot.data.telephoneNo,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.email),
                                    Text(
                                      snapshot.data.email,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Container();
                      }),
                ),
                SizedBox(
                  height: 50.0,
                  child: AppBar(
                    backgroundColor: Colors.red,
                    bottom: TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            'Menu List',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        //Tab(child: Text('Drinks'),),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Container(
                        child: ListView(
                          children: <Widget>[
                            MaterialButton(
                              onPressed: () {},
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/default.png'),
                                      radius: 30.0,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text('Spicy Chicken McDeluxe'),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text('RM 20.00'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
