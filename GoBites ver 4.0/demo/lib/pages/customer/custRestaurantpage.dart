import 'dart:async';
import 'dart:core';

import 'package:demo/modules/custdetail.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:demo/pages/customer/custMenupage.dart';
import 'custHomepage.dart';
import 'cartpage.dart';

class CustRestaurantPage extends StatefulWidget {
  @override
  _CustRestaurantPageState createState() => _CustRestaurantPageState();
}

class _CustRestaurantPageState extends State<CustRestaurantPage> {
  Future<List<RestList>> restaurants;
  Future<CustDetail> futureCustDetail;

  List<RestList> _restList = List<RestList>();
  List<RestList> _restListDisplay = List<RestList>();

  Future<List<RestList>> fetchRestaurantList() async {
    final response = await http_get('/restaurants');

    var restList = List<RestList>();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var restJson = json.decode(response.body);
      for (var resJson in restJson) {
        restList.add(RestList.fromJson(resJson));
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load album, code = ' + response.statusCode.toString());
    }
    return restList;
  }

  @override
  void initState() {
    fetchRestaurantList().then((value) {
      setState(() {
        _restList.addAll(value);
        _restListDisplay = _restList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new CustHomePage()),
                (route) => false),
          ),
          backgroundColor: Colors.blue,
          title: Text('Pick a Restaurant'),
          centerTitle: true,
          actions: [
            FutureBuilder<int>(
                future: fetchCartQuantity(cust.CID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                                '${snapshot.data.toString()}',
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
                })
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : _listRestaurant(index - 1);
          },
          itemCount: _restListDisplay.length + 1,
        ));
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Search'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _restListDisplay = _restList.where((restsearch) {
              var restName = restsearch.restaurantname.toLowerCase();
              return restName.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listRestaurant(index) {
    return Card(
      child: Column(
        children: <Widget>[
          OutlineButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CustMenuPage(rest: _restListDisplay[index])));
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
                    _restListDisplay[index].restaurantname,
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
  }

  // Widget restaurantListView(BuildContext context, AsyncSnapshot snapshot) {
  //   List<RestList> restaurants = snapshot.data;
  //   return ListView.builder(
  //       padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
  //       itemCount: snapshot.data.length,
  //       scrollDirection: Axis.vertical,
  //       itemBuilder: (context, index) {
  //         return Card(
  //           elevation: 10.0,
  //           child: Column(
  //             children: <Widget>[
  //               OutlineButton(
  //                 onPressed: () {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) =>
  //                               CustMenuPage(rest: restaurants[index])));
  //                 },
  //                 padding: EdgeInsets.all(10.0),
  //                 child: Row(
  //                   children: <Widget>[
  //                     Expanded(
  //                       flex: 1,
  //                       child: CircleAvatar(
  //                         backgroundImage: AssetImage('assets/default.png'),
  //                         radius: 30.0,
  //                       ),
  //                     ),
  //                     Expanded(
  //                       flex: 3,
  //                       child: Text(
  //                         restaurants[index].restaurantname,
  //                         style: TextStyle(
  //                           fontSize: 20.0,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
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
