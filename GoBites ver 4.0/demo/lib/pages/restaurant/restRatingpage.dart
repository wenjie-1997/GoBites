import 'dart:convert';
import 'dart:ui';

import 'package:demo/modules/http.dart';
import 'package:demo/pages/restaurant/restHomepage.dart';
import 'package:demo/pages/restaurant/restaurantInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantRatingPage extends StatefulWidget {
  @override
  _RestaurantRatingPageState createState() => _RestaurantRatingPageState();
}

class _RestaurantRatingPageState extends State<RestaurantRatingPage> {
  Future<double> futurerating;

  Future<double> getRating() async {
    final response = await http_get('/getrating/' + rest.RID.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body).toDouble();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load detail, code = ' + response.statusCode.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    futurerating = getRating();
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                  child: Column(children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                    child: Text(
                      'Average Rating',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    )),
                FutureBuilder<double>(
                  future: futurerating,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Align(
                        alignment: Alignment.center,
                        child: RatingBarIndicator(
                          rating: snapshot.data,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 50,
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
                        itemSize: 50,
                        direction: Axis.horizontal,
                      ),
                    );
                  },
                ),
              ])),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                  child: Container(
                      color: Colors.blue,
                      child: AppBar(
                        title: Text(
                          'Feedback List',
                          style: TextStyle(fontSize: 20),
                        ),
                        centerTitle: true,
                        leading: Container(),
                        backgroundColor: Colors.lightBlue,
                      )))
            ],
          ),
        ));
  }
}
