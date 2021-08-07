import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:demo/pages/customer/custMenupage.dart';
import 'dart:async';
import 'dart:core';
import 'package:demo/modules/restdetail.dart';
import 'package:demo/modules/http.dart';

//List<RestList> parseRestaurants(String responseBody) {
//final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

//return parsed.map<RestList>((json) => RestList.fromJson(json)).toList();
//}

class CustRestaurantList extends StatefulWidget {
  @override
  _CustRestaurantListState createState() => _CustRestaurantListState();
}

class _CustRestaurantListState extends State<CustRestaurantList> {
  List<RestList> _restList = List<RestList>();
  List<RestList> _restListDisplay = List<RestList>();

  Future<List<RestList>> fetchRestaurantList() async {
    final response = await http_get('/restaurants');

    var restList = List<RestList>();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var restJson = json.decode(response.body);
      for (var resJson in restJson) {
        restList.add(RestList.fromJson(resJson));
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load album, code = ' + response.statusCode.toString());
    }
    return restList;
  }

  @override
  void initState() {
    fetchRestaurantList().then((value) {
      setState(() {
        _restList.addAll(value);
        _restListDisplay = _restList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text('Select Restaurant'),
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : _listRestaurant(index - 1);
          },
          itemCount: _restListDisplay.length + 1,
        ));
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Search'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _restListDisplay = _restList.where((restsearch) {
              var restName = restsearch.restaurantname.toLowerCase();
              return restName.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listRestaurant(index) {
    return Card(
      child: Column(
        children: <Widget>[
          OutlineButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CustMenuPage(rest: _restListDisplay[index])));
            },
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
                  flex: 3,
                  child: Text(
                    _restListDisplay[index].restaurantname,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//class RestaurantSearch extends SearchDelegate<String>{
//@override
//List<Widget> buildActions(BuildContext context) {
//return [
//IconButton(
//icon: Icon(Icons.clear),
//onPressed: () {},
//)
//];
//}

//@override
//Widget buildLeading(BuildContext context) {
//return IconButton(
//icon: AnimatedIcon(
//icon: AnimatedIcons.menu_arrow,
//progress: transitionAnimation,
//),
//onPressed: null);
//}

//@override
//Widget buildResults(BuildContext context) {
////
//}

//@override
//Widget buildSuggestions(BuildContext context) {
//List<RestList> restaurants;
//final suggestionList = query.isEmpty ? restaurants : restaurants;
//return ListView.builder(
//itemBuilder: (context, index) => ListTile(
//leading: Icon(Icons.ac_unit),
//title: Text(restaurants[index].restaurantname),
//),
//itemCount: restaurants.length,
//);
//}
//}
