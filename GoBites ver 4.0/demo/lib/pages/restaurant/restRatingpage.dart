import 'dart:convert';
import 'dart:ui';

import 'package:demo/modules/feedback.dart';
import 'package:demo/modules/http.dart';
import 'package:demo/pages/restaurant/restHomepage.dart';
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

  List<Feedbacks> parseFeedback(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Feedbacks>((json) => Feedbacks.fromJson(json)).toList();
  }

  Future<List<Feedbacks>> fetchFeedback() async {
    final response = await http_get('/getfeedbackrest/' + rest.RID.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseFeedback(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load, code = ' + response.statusCode.toString());
    }
  }

  Future<List<Feedbacks>> futureFeedbackList;
  @override
  void initState() {
    super.initState();
    futurerating = getRating();
    futureFeedbackList = fetchFeedback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
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
                      ))),
              FutureBuilder<List<Feedbacks>>(
                  future: futureFeedbackList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return feedbackListView(context, snapshot);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error);
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        )*/
        body: SingleChildScrollView(
            child: Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 40, left: 20),
        child: Stack(children: [
          Ink(
            decoration: const ShapeDecoration(
              color: Colors.orange,
              shape: CircleBorder(),
            ),
            child: IconButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new RestHomePage()),
                    (route) => false),
                icon: Icon(Icons.arrow_back, color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text("My Rating",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
          )
        ]),
      ),
      Container(
        child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Average Rating',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )),
      ),
      Container(
        child: FutureBuilder<double>(
          future: futurerating,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
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
            return Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
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
      ),
      Container(
          height: 60,
          width: double.infinity,
          color: Colors.orange,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Feedback List',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          )),
      Container(
        child: FutureBuilder<List<Feedbacks>>(
            future: futureFeedbackList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return feedbackListView(context, snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error);
              }
              return Center(child: CircularProgressIndicator());
            }),
      )
    ])));
  }

  Widget feedbackListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Feedbacks> feedbackrest = snapshot.data;
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                Text(
                  'Feedback ID: ${feedbackrest[index].FID.toString()}',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RatingBarIndicator(
                  rating: feedbackrest[index].rating,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 50,
                  direction: Axis.horizontal,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Comment Received:',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '${feedbackrest[index].comment}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          );
        });
  }
}
