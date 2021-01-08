import 'dart:convert';

import 'package:demo/modules/http.dart';
import 'package:demo/modules/restdetail.dart';
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
  List<RestDetail> parseOrder(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<RestDetail>((json) => RestDetail.fromJson(json)).toList();
  }

  Future<List<RestDetail>> fetchOrder(int oid) async {
    final response =
        await http_get('/vieworderrestaurant/' + widget.oid.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseOrder(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load, code = ' + response.statusCode.toString());
    }
  }

  final _formKey = GlobalKey<FormState>();
  double rating;
  String comment;
  int rid;

  Future makeRating() async {
    final msg = jsonEncode(
        {"rating": rating, "comment": comment, "OID": widget.oid, "RID": rid});
    final result = await http_post("/makerating", msg);
    String status = jsonDecode(result.body);
    if (status == "Rate Successful") {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Rate Successful"),
                actions: <Widget>[
                  TextButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerOrderRatingPage()));
                    },
                  )
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
  Widget build(BuildContext context) {
    rating = 3;
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
        body: Container(
          //key: _formKey,
          child:
              /*Center(
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
                    onRatingUpdate: (double value) {
                      setState(() {
                        rating = value;
                      });
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
                        onChanged: (value) {
                          setState(() {
                            comment = value;
                          });
                        },
                      ),
                    ]),
                  ),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            makeRating();
                          }
                        },
                        child: Text(
                          "Give Rating",
                        ),
                      ))
                ],
              ),
            )*/
              FutureBuilder<List<RestDetail>>(
                  future: fetchOrder(widget.oid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return orderRestView(context, snapshot);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error);
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
        ));
  }

  Widget orderRestView(BuildContext context, AsyncSnapshot snapshot) {
    List<RestDetail> orderrest = snapshot.data;
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Text(
                'Rating for ${orderrest[index].restaurantname}',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'ID: ${orderrest[index].RID.toString()}',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
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
                      onRatingUpdate: (double value) {
                        setState(() {
                          rating = value;
                        });
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
                          onChanged: (value) {
                            setState(() {
                              comment = value;
                            });
                          },
                        ),
                      ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        onPressed: () {
                          rid = orderrest[index].RID;
                          if (_formKey.currentState.validate()) {
                            makeRating();
                          }
                        },
                        child: Text(
                          "Give Rating",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}