import 'package:flutter/material.dart';
import 'package:gobites/screens/customer_home/customer_home.dart';
import 'package:gobites/screens/customer_profile/customer_profile.dart';

import 'customer_bottom_nav/customer_bottom_nav.dart';

class CustomerMain extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => CustomerMain());
  @override
  _CustomerMainState createState() => _CustomerMainState();
}

class _CustomerMainState extends State<CustomerMain> {
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
      'Widget': CustomerHome(),
    },
    {
      'icon': Icons.person,
      'label': 'Profile',
      'Widget': CustomerProfile(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _navBarItem[_selectedIndex]['Widget'],
        bottomNavigationBar: CustBottomNav(
          index: _selectedIndex,
          onTap: _onItemTapped,
          navBarItem: _navBarItem,
        ));
  }
}
