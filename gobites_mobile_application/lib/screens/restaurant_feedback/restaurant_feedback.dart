import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/screens/restaurant_feedback/restaurant_feedback_viewmodel.dart';
import 'package:gobites/screens/view.dart';

class RestaurantFeedback extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => RestaurantFeedback());
  // Future<double> getRating() async {
  //   final response = await http_get('/getrating/' + rest.RID.toString());
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return jsonDecode(response.body).toDouble();
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception(
  //         'Failed to load detail, code = ' + response.statusCode.toString());
  //   }
  // }

  // List<Feedbacks> parseFeedback(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  //   return parsed.map<Feedbacks>((json) => Feedbacks.fromJson(json)).toList();
  // }

  // Future<List<Feedbacks>> fetchFeedback() async {
  //   final response = await http_get('/getfeedbackrest/' + rest.RID.toString());
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return parseFeedback(response.body);
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception(
  //         'Failed to load, code = ' + response.statusCode.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<RestaurantFeedbackViewmodel>()..init(),
        builder: (context, viewmodel, _) {
          RestaurantFeedbackViewmodel _viewmodel = viewmodel;
          return Scaffold(
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
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("My Rating",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30))),
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
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
              child: RatingBarIndicator(
                rating: _viewmodel.averageRating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 50,
                direction: Axis.horizontal,
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
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                itemCount: _viewmodel.feedbackList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Feedback ID:${_viewmodel.feedbackList[index].id.toString()}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RatingBarIndicator(
                          rating: _viewmodel.feedbackList[index].rating,
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
                          '${_viewmodel.feedbackList[index].comment}',
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
                })
          ])));
        });
  }
}
