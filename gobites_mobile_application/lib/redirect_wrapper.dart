// import 'package:flutter/material.dart';
// import 'package:gobites/screens/customer_main/customer_main.dart';
// import 'package:gobites/screens/login/login.dart';
// import 'package:gobites/screens/restaurant_main/restaurant_main.dart';
// // import 'app/auth.dart';
// import 'app/dependencies.dart';

// class RedirectWrapper extends StatelessWidget {
//   static MaterialPageRoute route() =>
//       MaterialPageRoute(builder: (_) => RedirectWrapper());

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: dependency<JwtService>().isLoggedIn(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData)
//             return Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );

//           //if not logged in
//           if (snapshot.data) {
//             if (user.userType == "customer") {
//               return CustomerMain();
//             }
//             if (user.userType == "restaurant") {
//               return RestaurantMain();
//             }
//           }
//           return Login();
//         });
//   }
// }
