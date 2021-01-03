import 'package:demo/pages/customer/custOrderRatingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MakeRatingPage extends StatefulWidget {
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
                  builder: (BuildContext context) => new CustomerOrderRatingPage()),
              (route) => false),
        ),
        title: Text('Make Rating'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      
    );
  }
}