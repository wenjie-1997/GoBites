import 'package:flutter/material.dart';

/*class CustomerMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Customer Menu Page',
      home: CustMenuPage(),
    );
  }
}*/

class CustMenuPage extends StatefulWidget {
  @override
  _CustMenuPageState createState() => _CustMenuPageState();
}

class _CustMenuPageState extends State<CustMenuPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Make an Order'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
                height: 200.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          'Mc Donald\'s',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Details',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Mc Donald\'s is....',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Operating Hours',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'All Day',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '9am to 9pm',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Contact Us',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.phone),
                          Text(
                            '0X-XXXXXXX',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.email),
                          Text(
                            'XXXXXX@XXX.com',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 50.0,
              child: AppBar(
                backgroundColor: Colors.red,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'Menu List',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    //Tab(child: Text('Drinks'),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    child: ListView(
                      children: <Widget>[
                        MaterialButton(
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
                  /*Container(
                    child: ListView(
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            
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
                                flex: 2,
                                child: Text(
                                  'Iced Lemon Tea'
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'RM 5.00'
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /*_showRestaurantDetail() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              backgroundColor: Colors.amber[100],
              title: new Text(
                "Restaurant Details",
              ),
              content: new Container(
                height: 300.0,
                width: 200.0,
                child: ListView(
                  children: <Widget>[
                    Text(
                      'Name',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Mc Donald\'s',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Details',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Mc Donald\'s is....',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Operating Hours',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'All Day',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '9am to 9pm',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Contact Us',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.phone),
                        Text(
                          '0X-XXXXXXX',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.email),
                        Text(
                          'XXXXXX@XXX.com',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                )
              ],
            ));
  }*/
}
