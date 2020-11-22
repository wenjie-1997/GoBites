import 'package:flutter/material.dart';

/*class RestaurantPersonalInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "View Restaurant Info",
      home: RestaurantPersonalInfoPage(),
    );
  }
}*/

class RestaurantPersonalInfoPage extends StatefulWidget {
  @override
  _RestaurantPersonalInfoPageState createState() => _RestaurantPersonalInfoPageState();
}

class _RestaurantPersonalInfoPageState extends State<RestaurantPersonalInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
          ),
        title: Text('Restaurant Info'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/default.png'),
                radius: 50.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.red,
            ),
            Text(
              'Username:',
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'XXXXXXXXX',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Password:',
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'XXXXXXXXXX',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Restaurant Name:',
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'XXX XXX XXX',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Email Address:',
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'XXXXXX@XXX.com',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Restaurant Owner Name:',
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'XXX XXX XXX',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Restaurant Type/Style:',
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'XXX',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Address:',
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'XXXXXXXXX',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.yellow[100],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Restaurant Info'),
        ],
        currentIndex: 1,
      ),
    );
  }
}
