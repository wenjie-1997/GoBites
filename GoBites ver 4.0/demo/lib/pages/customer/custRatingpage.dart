import 'package:demo/pages/customer/custOrderRatingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MakeRatingPage extends StatefulWidget {
  final int oid;
  MakeRatingPage({Key key, @required this.oid}) : super(key: key);
  @override
  _MakeRatingPageState createState() => _MakeRatingPageState();
}

class _MakeRatingPageState extends State<MakeRatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new CustomerOrderRatingPage()),
              (route) => false),
        ),
        title: Text('Make Rating'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text('Order ID: ${widget.oid.toString()}'),
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
                onRatingUpdate: (rating) {
                print(rating);
                },
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                TextFormField(
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
