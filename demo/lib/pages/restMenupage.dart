import 'package:flutter/material.dart';

/*class RestaurantMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Restaurant Menu Page',
      home: RestMenuPage(),
    );
  }
}*/

class RestMenuPage extends StatefulWidget {
  @override
  _RestMenuPageState createState() => _RestMenuPageState();
}

class _RestMenuPageState extends State<RestMenuPage> {
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
        title: Text('My Menu'),
        centerTitle: true,
      ),
      body: Padding(
        padding: 
          EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: ListView(
            children: <Widget>[
              OutlineButton(
                onPressed: () {},
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
                      flex: 2,
                      child: Text('Spicy Chicken McDeluxe'),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text('RM 20.00'),
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