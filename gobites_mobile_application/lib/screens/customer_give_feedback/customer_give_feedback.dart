import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/order.dart';
import 'package:gobites/models/restaurant.dart';
import 'package:gobites/screens/customer_feedbck/customer_feedback_viewmodel.dart';
import 'package:gobites/screens/register/widget/custom_text_field.dart';
import 'package:gobites/screens/view.dart';

class CustomerGiveFeedback extends StatelessWidget {
  static route(args) =>
      MaterialPageRoute(builder: (context) => CustomerGiveFeedback(args));

  final Order order;
  CustomerGiveFeedback(this.order);
  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<CustomerFeedbackViewmodel>()
          ..initForGiveFeedback(order.oid),
        builder: (context, viewmodel, _) {
          CustomerFeedbackViewmodel _viewmodel = viewmodel;
          return Container(
            child: Scaffold(
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
                      padding: EdgeInsets.only(top: 7),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text("Give Feedback",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30))),
                    )
                  ]),
                ),
                orderRestView(context, _viewmodel)
              ]),
            )),
          );
        });
  }

  Widget orderRestView(
      BuildContext context, CustomerFeedbackViewmodel viewmodel) {
    Restaurant restaurant = viewmodel.restaurant;

    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Restaurant: ${restaurant.restaurantname}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: viewmodel.formKey,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Rating",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (double value) => viewmodel.rating = value,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Comment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 6,
                    decoration: textFieldDecoration(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) => viewmodel.comment = value,
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Material(
                        elevation: 3.0,
                        color: Colors.orange,
                        child: MaterialButton(
                          onPressed: () {
                            if (viewmodel.formKey.currentState.validate()) {
                              viewmodel.onSubmit(order.oid);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Feedback has been submitted successfully.'),
                                duration: Duration(seconds: 3),
                              ));
                            }
                          },
                          child: Text(
                            "Submit",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
