import 'package:flutter/material.dart';
import 'restAddMenupage.dart';
import 'restMenuUpdatepage.dart';

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
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  Container(
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
                          flex: 2,
                          child: Text('McChicken'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('RM 10.00'),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => RestMenuUpdatePage()));
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.black,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RestAddMenuPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
