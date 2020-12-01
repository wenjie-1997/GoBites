import 'dart:convert';
import 'package:demo/modules/menu.dart';
import 'package:flutter/material.dart';
import 'package:demo/modules/http.dart';
import 'package:demo/modules/restdetail.dart';
import 'cartpage.dart';

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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    futureCustRestDetail = fetchRestDetail(this.widget.rest.RID.toString());
    futureMenuList = fetchMenu(this.widget.rest.RID.toString());
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
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: 
                    (context) => CartPage())
                    );
                  },
                  ),
              ],
            ),
            body: Column(children: <Widget>[
              SizedBox(
                height: 200.0,
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: FutureBuilder<CustRestDetail>(
                      future: futureCustRestDetail,
                      builder: (content, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
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
                                      fontSize: 25.0,
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
                  child: TabBarView(children: [
                FutureBuilder(
                    future: futureMenuList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return menuListView(context, snapshot);
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error);
                      }
                      return Center(child: CircularProgressIndicator());
                    })
                // MaterialButton(
                //   onPressed: () {},
                //   padding: EdgeInsets.all(10.0),
                //   child: Row(
                //     children: <Widget>[
                //       Expanded(
                //         flex: 1,
                //         child: CircleAvatar(
                //           backgroundImage: AssetImage('assets/default.png'),
                //           radius: 30.0,
                //         ),
                //       ),
                //       Expanded(
                //         flex: 2,
                //         child: Text('Spicy Chicken McDeluxe'),
                //       ),
                //       Expanded(
                //         flex: 1,
                //         child: Text('RM 20.00'),
                //       ),
                //     ],
                //   ),
                // )
              ]))
            ])));
  }

  Widget menuListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Menu> menus = snapshot.data;
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        itemCount: snapshot.data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10.0,
            child: Column(
              children: <Widget>[
                MaterialButton(
                  onPressed: () {},
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
                        flex: 2,
                        child: Text(menus[index].itemName),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                            'RM ${menus[index].itemPrice.toStringAsFixed(2)}'),
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
