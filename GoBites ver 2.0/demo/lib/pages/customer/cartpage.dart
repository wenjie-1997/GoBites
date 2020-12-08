import 'dart:convert';
import 'package:demo/modules/cart.dart';
import 'package:demo/modules/custdetail.dart';
import 'package:demo/modules/menu.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/http.dart';
import 'package:demo/modules/restdetail.dart';
import 'personalInfo.dart' as info;

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<CustDetail> futureCustDetail;

  List<Cart> parseCart(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
  }

  Future<List<Cart>> fetchCart(int cid) async {
    final response = await http_get('/viewcart/' + cid.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseCart(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load, code = ' + response.statusCode.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCustDetail = info.fetchCustDetail();
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
          title: Text('My Cart'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: FutureBuilder(
          future: futureCustDetail,
          builder: (context, snapshot1) {
            if (snapshot1.hasData) {
              return FutureBuilder(
                future: fetchCart(snapshot1.data.CID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return cartListView(context, snapshot);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            } else if (snapshot1.hasError) {
              return Text(snapshot1.error);
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget cartListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Cart> carts = snapshot.data;
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        itemCount: snapshot.data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            child: Column(
              children: <Widget>[
                Container(
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
                        child: Text(carts[index].itemName),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('Quantity: ${carts[index].quantity}'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                            'RM ${carts[index].itemPrice.toStringAsFixed(2)}'),
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
