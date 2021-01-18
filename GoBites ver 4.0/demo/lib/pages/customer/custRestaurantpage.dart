import 'dart:async';
import 'dart:core';

import 'package:demo/modules/custdetail.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:demo/pages/customer/custMenupage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'cartpage.dart';
import 'custHomepage.dart';

class CustRestaurantPage extends StatefulWidget {
  @override
  _CustRestaurantPageState createState() => _CustRestaurantPageState();
}

class _CustRestaurantPageState extends State<CustRestaurantPage> {
  Future<List<RestList>> restaurants;
  Future<CustDetail> futureCustDetail;

  List<RestList> _restList = List<RestList>();
  List<RestList> _restListDisplay = List<RestList>();

  Future<double> futurerating;

  Future<double> getRestaurantRating(int rid) async {
    final response = await http_get('/getrating/' + rid.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body) != null
          ? jsonDecode(response.body).toDouble()
          : 0;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load detail, code = ' + response.statusCode.toString());
    }
  }

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
    // appBar: AppBar(
    //   leading: IconButton(
    //     icon: Icon(Icons.arrow_back, color: Colors.black),
    //     onPressed: () => Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(
    //             builder: (BuildContext context) => new CustHomePage()),
    //         (route) => false),
    //   ),
    //   backgroundColor: Colors.blue,
    //   title: Text('Pick a Restaurant'),
    //   centerTitle: true,
    //   actions: [
    //     FutureBuilder<int>(
    //         future: fetchCartQuantity(cust.CID),
    //         builder: (context, snapshot) {
    //           if (snapshot.hasData) {
    //             return IconButton(
    //               icon: new Stack(
    //                 children: <Widget>[
    //                   new Icon(
    //                     Icons.shopping_cart_rounded,
    //                     size: 30,
    //                   ),
    //                   new Positioned(
    //                     right: 0,
    //                     child: new Container(
    //                       padding: EdgeInsets.all(1),
    //                       decoration: new BoxDecoration(
    //                         color: Colors.red,
    //                         borderRadius: BorderRadius.circular(8),
    //                       ),
    //                       constraints: BoxConstraints(
    //                         minWidth: 12,
    //                         minHeight: 12,
    //                       ),
    //                       child: new Text(
    //                         '${snapshot.data.toString()}',
    //                         style: new TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 12,
    //                         ),
    //                         textAlign: TextAlign.center,
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //               onPressed: () {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => CartPage()));
    //               },
    //             );
    //           } else if (snapshot.hasError) {
    //             return Text(snapshot.error);
    //           }
    //           return Center(child: CircularProgressIndicator());
    //         })
    //   ],
    // ),
    return Scaffold(
        body: Column(children: [
      Stack(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(top: 50, left: 20),
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.orange,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new CustHomePage()),
                          (route) => false),
                      icon: Icon(Icons.arrow_back, color: Colors.white)),
                ))),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(top: 55, left: 20, right: 20),
                child: Text("Select Restaurant",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)))),
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
                padding: EdgeInsets.only(top: 50, right: 20),
                child: FutureBuilder<int>(
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
                    })))
      ]),
      new Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return index == 0 ? _searchBar() : _listRestaurant(index - 1);
                },
                itemCount: _restListDisplay.length + 1,
              )))
    ]));
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
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
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(bottom: 20),
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              ListTile(
                title: new Text(_restListDisplay[index].restaurantname,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                subtitle: Text(
                  _restListDisplay[index].address,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6), fontSize: 16),
                ),
              ),
              Builder(
                builder: (context) {
                  if (_restListDisplay[index].image != null) {
                    return Image.network(
                      "http://$DOMAIN/" + _restListDisplay[index].image,
                      height: 200,
                    );
                  } else {
                    return Image(
                      image: AssetImage('assets/default.png'),
                      height: 200,
                    );
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4, // 20%
                    child: Text(
                      'Style',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      _restListDisplay[index].restaurantstyle,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4, // 20%
                    child: Text(
                      'Telephone No.',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      _restListDisplay[index].telephoneNo,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4, // 20%
                    child: Text(
                      'Email',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      _restListDisplay[index].email,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                          textColor: const Color(0xFF6200EE),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustMenuPage(
                                        rest: _restListDisplay[index])));
                          },
                          child: const Text('View Menu'),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FutureBuilder<double>(
                      future: getRestaurantRating(_restListDisplay[index].RID),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: RatingBarIndicator(
                              rating: snapshot.data,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20,
                              direction: Axis.horizontal,
                            ),
                          );
                        }
                        return Align(
                          alignment: Alignment.center,
                          child: RatingBarIndicator(
                            rating: 0,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20,
                            direction: Axis.horizontal,
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
