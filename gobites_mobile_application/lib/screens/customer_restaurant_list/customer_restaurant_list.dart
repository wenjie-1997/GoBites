import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/restaurant.dart';
import 'package:gobites/screens/customer_restaurant_list/customer_restaurant_list_viewmodel.dart';
import 'package:gobites/screens/view.dart';

class CustomerRestaurantList extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => CustomerRestaurantList());

  _searchBar(CustomerRestaurantListViewmodel viewmodel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Search'),
        onChanged: (text) {
          text = text.toLowerCase();
          viewmodel.displaySearchResult(text);
        },
      ),
    );
  }

  _listRestaurant(Restaurant restaurant, Function viewMenu) {
    return Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(bottom: 20),
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              ListTile(
                title: new Text(restaurant.restaurantname,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                subtitle: Text(
                  restaurant.address,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6), fontSize: 16),
                ),
              ),
              Builder(
                builder: (context) {
                  // if (restaurant != null) {
                  //   return Image.network(
                  //     "http://$DOMAIN/" + restaurant.image,
                  //     height: 200,
                  //   );
                  // } else {
                  return Image(
                    image: AssetImage('assets/default.png'),
                    height: 200,
                  );
                  // }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4, // 20%
                    child: Text(
                      'Style',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      restaurant.restaurantstyle,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4, // 20%
                    child: Text(
                      'Telephone No.',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      restaurant.telephoneNo,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4, // 20%
                    child: Text(
                      'Email',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      restaurant.email,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                          textColor: const Color(0xFF6200EE),
                          onPressed: viewMenu,
                          child: const Text('View Menu'),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: restaurant.rating != -1
                            ? RatingBarIndicator(
                                rating: restaurant.rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20,
                                direction: Axis.horizontal,
                              )
                            : Text(
                                'No rating',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                      ))
                ],
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<CustomerRestaurantListViewmodel>()..init(),
        builder: (context, viewmodel, _) {
          CustomerRestaurantListViewmodel _viewmodel = viewmodel;
          return Scaffold(
              body: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Stack(children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.orange,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back, color: Colors.white)),
                    )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text("Restaurant List",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                    )),
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: new Stack(
                        children: <Widget>[
                          new Icon(
                            Icons.shopping_cart_rounded,
                            size: 30,
                          ),
                          new Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/cust_cart');
                      },
                    ))
              ]),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return index == 0
                      ? _searchBar(_viewmodel)
                      : _listRestaurant(
                          _viewmodel.displayedRestaurantList[index - 1],
                          () => Navigator.pushNamed(
                              context, '/cust_restaurant_menu',
                              arguments: _viewmodel
                                  .displayedRestaurantList[index - 1]));
                },
                itemCount: _viewmodel.displayedRestaurantList.length + 1,
              ),
            )
          ]));
        });
  }
}
