import 'dart:convert';
import 'package:demo/modules/orderItem.dart';
import 'package:demo/modules/orders.dart';
import 'package:demo/modules/custdetail.dart';
import 'package:demo/pages/customer/custViewOrderDetailpage.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';
import 'custHomepage.dart';

class CustomerViewOrderPage extends StatefulWidget {
  @override
  _CustomerViewOrderPageState createState() => _CustomerViewOrderPageState();
}

class _CustomerViewOrderPageState extends State<CustomerViewOrderPage> {
  Future<CustDetail> fetchCustDetail() async {
    final response = await http_get('/customer/' + login.login_id);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return CustDetail.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load album, code = ' + response.statusCode.toString());
    }
  }

  List<Orders> parseOrderId(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Orders>((json) => Orders.fromJson(json)).toList();
  }

  Future<List<Orders>> fetchOrderId(int cid) async {
    print(cid);
    final response = await http_get('/vieworderidcust/' + cid.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseOrderId(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load, code = ' + response.statusCode.toString());
    }
  }

  Future<List<Orders>> futureOrderIdList;
  Future<CustDetail> futureCustDetail;
  CustDetail cust;
  @override
  void initState() {
    super.initState();
    futureCustDetail = fetchCustDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new CustHomePage())),
        ),
        title: Text('Order List'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          child: FutureBuilder<CustDetail>(
              future: futureCustDetail,
              builder: (context, snapshot1) {
                if (snapshot1.hasData) {
                  return FutureBuilder<List<Orders>>(
                      future: fetchOrderId(snapshot1.data.CID),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return orderIdListView(context, snapshot);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return Center(child: CircularProgressIndicator());
                      });
                } else if (snapshot1.hasError) {
                  return Text(snapshot1.error);
                }
                return Center(child: CircularProgressIndicator());
              })),
    );
  }

  Widget orderIdListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Orders> orderids = snapshot.data;
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        itemCount: snapshot.data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            child: Column(
              children: <Widget>[
                MaterialButton(
                  onPressed: (){
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerViewOrderDetailPage(oid:orderids[index].OID)));
                  },
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          'ID: ${orderids[index].OID.toString()}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'RM ${orderids[index].totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18.0,
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
