import 'dart:convert';

import 'package:demo/modules/http.dart';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/pages/restaurant/restHomepage.dart';
import 'package:demo/pages/login.dart' as login;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantRatingPage extends StatefulWidget {
  @override
  _RestaurantRatingPageState createState() => _RestaurantRatingPageState();
}

class _RestaurantRatingPageState extends State<RestaurantRatingPage> {
  Future<RestDetail> fetchRestDetail() async {
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new RestHomePage()),
              (route) => false),
        ),
        title: Text('My Rating'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 200.0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
              child: Text('Average Rating')
            ),
          ),
          SizedBox(
            height: 50.0,
            child: AppBar(
              title: Text('Feedback List'),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
          ),

        ],
        ),
    );
  }
}