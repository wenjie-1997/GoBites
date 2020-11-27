import 'dart:convert';
import 'package:demo/modules/http.dart';
import 'package:flutter/material.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:demo/modules/restdetail.dart';
import 'restInfoUpdatepage.dart';

Future<RestDetail> fetchRestDetail() async {
  print("Im here");
  final response = await http_get('/restaurant/' + login.login_id);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return RestDetail.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load detail, code = ' + response.statusCode.toString());
  }
}

class RestaurantPersonalInfoPage extends StatefulWidget {
  @override
  _RestaurantPersonalInfoPageState createState() =>
      _RestaurantPersonalInfoPageState();
}

class _RestaurantPersonalInfoPageState
    extends State<RestaurantPersonalInfoPage> {
  Future<RestDetail> futureRestDetail;

  @override
  void initState() {
    super.initState();
    futureRestDetail = fetchRestDetail();
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
        title: Text('Restaurant Info'),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RestInfoUpdatePage()));
            },
          ),
        ],
      ),
      body: FutureBuilder<RestDetail>(
          future: futureRestDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/default.png'),
                        radius: 50.0,
                      ),
                    ),
                    Divider(
                      height: 60.0,
                      color: Colors.red,
                    ),
                    Text(
                      'Username:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      snapshot.data.username,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Password:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      snapshot.data.password,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Restaurant Name:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      snapshot.data.restaurantname,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Email Address:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      snapshot.data.email,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Restaurant Owner Name:',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      snapshot.data.ownername,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Restaurant Type/Style:',
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
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Address:',
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
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.yellow[100],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Restaurant Info'),
        ],
        currentIndex: 1,
      ),
    );
  }
}
