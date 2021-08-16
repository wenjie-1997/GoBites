import 'package:flutter/material.dart';

class CustomerHome extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => CustomerHome());
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Customer Home"));
  }
}
