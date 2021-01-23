import 'dart:convert';
import 'dart:ui';
import 'package:demo/modules/custdetail.dart';
import 'package:demo/modules/menu.dart';
import 'package:demo/pages/customer/custHomepage.dart';
import 'package:demo/pages/customer/custRestaurantpage.dart';
import 'package:flutter/material.dart';
import 'package:demo/modules/http.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/pages/customer/cartpage.dart';

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

Future<int> fetchCartQuantity(int cid) async {
  final response = await http_get('/getcartquantity/' + cid.toString());
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("success");
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load, code = ' + response.statusCode.toString());
  }
}

List<Menu> parseMenu(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Menu>((json) => Menu.fromJson(json)).toList();
}

Future<List<Menu>> fetchMenu(String rid) async {
  final response = await http_get('/menu/' + rid);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parseMenu(response.body);
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
  Future<List<Menu>> futureMenuList;
  Future<CustDetail> futureCustDetail;
  int _quantity = 1;
  final ScrollController _scrollController = ScrollController();

  Future insertCart(int MID, int quantity) async {
    final msg = jsonEncode({
      "MID": MID,
      "quantity": quantity,
      "CID": cust.CID,
    });
    final result = await http_post("/addtocart", msg);
    String status = jsonDecode(result.body);
    if (status == "Insert Sucessful") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Add to Cart Sucessful"),
                actions: <Widget>[
                  TextButton(
                      child: Text('Continue'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new CustMenuPage(rest: widget.rest)));
                      }),
                ],
              ));
    } else {
      // AlertDialog(
      //   title: Text(status),
      //   actions: <Widget>[
      //     TextButton(
      //       child: Text('Continue'),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //   ],
      // );
    }
  }

  @override
  void initState() {
    super.initState();
    futureCustRestDetail = fetchRestDetail(this.widget.rest.RID.toString());
    futureMenuList = fetchMenu(this.widget.rest.RID.toString());
  }

  @override
  Widget build(BuildContext context) {
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
                                  new CustRestaurantPage()),
                          (route) => false),
                      icon: Icon(Icons.arrow_back, color: Colors.white)),
                ))),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(top: 55, left: 20, right: 20),
                child: Text("Menu Page",
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
      Expanded(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FutureBuilder(
                future: futureMenuList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return menuListView(context, snapshot);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error);
                  }
                  return Center(child: CircularProgressIndicator());
                })),
      )
    ]));
  }

  Widget menuListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Menu> menus = snapshot.data;
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        itemCount: snapshot.data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.only(bottom: 15),
            child: Column(
              children: <Widget>[
                MaterialButton(
                  onPressed: () {},
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Column(children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                menus[index].itemName,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    'RM ${menus[index].itemPrice.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 18))),
                          ])),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.black,
                            onPressed: () {
                              return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) =>
                                      new StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          title: Text("Add to Cart"),
                                          content: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      "Name: ${menus[index].itemName}\n"),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      "Price: RM${menus[index].itemPrice.toStringAsFixed(2)}\n"),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text("Quantity: "),
                                                    new IconButton(
                                                      icon: Icon(Icons.remove),
                                                      color: Colors.black,
                                                      onPressed: () =>
                                                          setState(() {
                                                        if (_quantity > 1) {
                                                          _quantity--;
                                                        }
                                                      }),
                                                    ),
                                                    new Text('$_quantity'),
                                                    new IconButton(
                                                      icon: Icon(Icons.add),
                                                      color: Colors.black,
                                                      onPressed: () => setState(
                                                          () => _quantity++),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                                child: Text('Continue'),
                                                onPressed: () {
                                                  insertCart(menus[index].MID,
                                                      _quantity);
                                                  Navigator.of(context).pop();
                                                }),
                                            TextButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                }),
                                          ],
                                        );
                                      }));
                            }),
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
