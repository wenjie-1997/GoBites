import 'package:flutter/material.dart';

class RestBottomNav extends StatelessWidget {
  final int index;
  final Function onTap;
  final List navBarItem;
  RestBottomNav({this.index, this.onTap, this.navBarItem});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        ...navBarItem.map((item) => BottomNavigationBarItem(
            icon: Icon(
              item['icon'],
            ),
            label: item['label']))
      ],
      currentIndex: index,
      selectedItemColor: Colors.amber[800],
      onTap: onTap,
    );
  }
}
