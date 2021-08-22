import 'package:flutter/material.dart';
import 'package:gobites/screens/restaurant_main/restaurant_bottom_nav/restaurant_bottom_nav.dart';
import 'package:gobites/screens/restaurant_home/restaurant_home.dart';
import 'package:gobites/screens/restaurant_profile/restaurant_profile.dart';

class RestaurantMain extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => RestaurantMain());
  @override
  _RestaurantMainState createState() => _RestaurantMainState();
}

class _RestaurantMainState extends State<RestaurantMain> {
// Future<RestDetail> fetchRestDetail() async {
//   final response = await http_get('/restaurant/' + login.login_id);

//   if (response.statusCode == 200) {
//     rest = RestDetail.fromJson(jsonDecode(response.body));
//     return RestDetail.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception(
//         'Failed to load album, code = ' + response.statusCode.toString());
//   }
// }

  // int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  List _navBarItem = [
    {
      'icon': Icons.home,
      'label': 'Home',
      'Widget': RestaurantHome(),
    },
    {
      'icon': Icons.person,
      'label': 'Profile',
      'Widget': RestaurantProfile(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _navBarItem[_selectedIndex]['Widget'],
        bottomNavigationBar: RestBottomNav(
          index: _selectedIndex,
          onTap: _onItemTapped,
          navBarItem: _navBarItem,
        ));
  }
}
