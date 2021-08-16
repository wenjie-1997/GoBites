import 'package:flutter/material.dart';

class RestaurantHome extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => RestaurantHome());
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Restaurant Home"));
  }
}
