import 'package:flutter/material.dart';
import 'custMenupage.dart';

/*class CustomerRestaurantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Customer Restaurant Page',
      home: CustRestaurantPage(),
    );
  }
}*/

class CustRestaurantPage extends StatefulWidget {
  @override
  _CustRestaurantPageState createState() => _CustRestaurantPageState();
}

class _CustRestaurantPageState extends State<CustRestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ), 
        backgroundColor: Colors.red,
        title: Text('Pick a Restaurant'),
        centerTitle: true,
      ),
      body: Padding(
        padding: 
          EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: ListView(
            children: <Widget>[
              OutlineButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: 
                            (context) => CustMenuPage())
                            );
                          },
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/default.png'),
                                  radius: 30.0,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text('Mc Donald\'s',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),),
                              ),
                            ],
                          ),
                        )
            ],
          ),
        ),

    );
  }
}