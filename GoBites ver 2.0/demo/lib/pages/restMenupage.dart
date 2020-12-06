import 'dart:convert';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/http.dart';
import 'package:demo/modules/menu.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/pages/restHomepage.dart';
import 'package:demo/pages/restaurantInfo.dart';
import 'package:flutter/material.dart';
import 'restAddMenupage.dart';
import 'restMenuUpdatepage.dart';

class RestMenuPage extends StatefulWidget {
  @override
  _RestMenuPageState createState() => _RestMenuPageState();
}

class _RestMenuPageState extends State<RestMenuPage> {
  Future<RestDetail> futureRestDetail;
  Future<List<Menu>> futureMenuList;
  Future<RestDetail> fetchRestDetail() async {
    final response = await http_get('/restaurant/' + login.login_id);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      rest = RestDetail.fromJson(jsonDecode(response.body));
      return RestDetail.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load detail, code = ' + response.statusCode.toString());
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
      throw Exception(
          'Failed to load, code = ' + response.statusCode.toString());
    }
  }

  Future menuDelete(int id) async {
    // print( widget.menu.MID.toString());
    final msg = jsonEncode({
      /*"itemName": itemName,
      "itemPrice": itemPrice,
      "itemPhoto": "default.png",
      "itemDesc": itemDesc,*/
       "MID": id,
    });
    final result = await http_post("/menudelete", msg);
    String status = jsonDecode(result.body);
    //String status = loginResult.getStatus();
    if (status == "Delete Sucessful") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Delete Successful"),
                actions: <Widget>[
                  TextButton(
                      child: Text('Continue'),
                      onPressed: () {Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
          MaterialPageRoute(
              builder: (BuildContext context) => new RestMenuPage()));
                      },)
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
    futureRestDetail = fetchRestDetail();
    futureMenuList = fetchMenu(rest.RID.toString());
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
                  builder: (BuildContext context) => new RestHomePage())),
        ),
        backgroundColor: Colors.red,
        title: Text('My Menu'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: FutureBuilder(
            future: futureMenuList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return menuListView(context, snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error);
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RestAddMenuPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
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
                        child: Text(menus[index].itemName),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                            'RM ${menus[index].itemPrice.toStringAsFixed(2)}'),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RestMenuUpdatePage(
                                        menu: menus[index])));
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.black,
                          onPressed: () {
                            deleteAlertDialog(context, menus[index].MID);
                          },
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

  deleteAlertDialog(BuildContext context, int id) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        menuDelete(id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Menu"),
      content: Text("Are you sure to delete this item?"),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
