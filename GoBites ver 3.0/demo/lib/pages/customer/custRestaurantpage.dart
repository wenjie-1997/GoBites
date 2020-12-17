import 'dart:async';
import 'dart:core';

import 'package:demo/modules/custdetail.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:demo/pages/customer/custMenupage.dart';
import 'personalInfo.dart';
import 'cartpage.dart';

List<RestList> parseRestaurants(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<RestList>((json) => RestList.fromJson(json)).toList();
}

Future<List<RestList>> fetchRestaurantList() async {
  final response = await http_get('/restaurants');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parseRestaurants(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load album, code = ' + response.statusCode.toString());
  }
}

class CustRestaurantPage extends StatefulWidget {
  @override
  _CustRestaurantPageState createState() => _CustRestaurantPageState();
}

class _CustRestaurantPageState extends State<CustRestaurantPage> {
  Future<List<RestList>> restaurants;
  Future<CustDetail> futureCustDetail;

  @override
  void initState() {
    super.initState();
    restaurants = fetchRestaurantList();
    futureCustDetail = fetchCustDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.red,
          title: Text('Pick a Restaurant'),
          centerTitle: true,
          actions: [
            FutureBuilder<CustDetail>(
              future: futureCustDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FutureBuilder<int>(
                      future: fetchCartQuantity(snapshot.data.CID),
                      builder: (context, snapshot1) {
                        if (snapshot1.hasData) {
                          return IconButton(
                            icon: new Stack(
                              children: <Widget>[
                                new Icon(
                                  Icons.shopping_cart_rounded,
                                  size: 30,
                                ),
                                new Positioned(
                                  right: 0,
                                  child: new Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: new BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 12,
                                      minHeight: 12,
                                    ),
                                    child: new Text(
                                      '${snapshot1.data.toString()}',
                                      style: new TextStyle(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartPage()));
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error);
                        }
                        return Center(child: CircularProgressIndicator());
                      });
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
        body: FutureBuilder<List<RestList>>(
          future: restaurants,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return restaurantListView(context, snapshot);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget restaurantListView(BuildContext context, AsyncSnapshot snapshot) {
    List<RestList> restaurants = snapshot.data;
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        itemCount: snapshot.data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10.0,
            child: Column(
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CustMenuPage(rest: restaurants[index])));
                  },
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/default.png'),
                          radius: 30.0,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          restaurants[index].restaurantname,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
// Padding(
//     padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
//     child: ListView(
//       children: <Widget>[
//         OutlineButton(
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => CustMenuPage()));
//           },
//           padding: EdgeInsets.all(10.0),
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 flex: 1,
//                 child: CircleAvatar(
//                   backgroundImage: AssetImage('assets/default.png'),
//                   radius: 30.0,
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Text(
//                   'Mc Donald\'s',
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     ),
//   ),
//     );
//   }
// }
