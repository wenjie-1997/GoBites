// import 'dart:async';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get_it/get_it.dart';
// import 'package:gobites/app/dependencies.dart';
// import 'package:gobites/services/auth/auth_service.dart';

// class JwtService implements Disposable {
//   final storage = new FlutterSecureStorage();
//   final loginStatusController = StreamController<bool>();
//   AuthService userDataService = dependency();

//   Future<void> triggerLogIn(String jwt) async {
//     storage.write(key: 'jwt', value: jwt);
//     loginStatusController.add(true);
//     user = await userDataService.getUser();
//   }

//   Future<void> triggerLogOut() async {
//     storage.delete(key: 'jwt');
//     loginStatusController.add(false);
//   }

//   Future<void> updateLoginStatus() async {
//     final jwt = await storage.read(key: 'jwt');
//     if (jwt != null) {
//       triggerLogIn(jwt);
//     } else {
//       triggerLogOut();
//     }
//   }

//   Stream<bool> isLoggedIn() {
//     updateLoginStatus();
//     return loginStatusController.stream;
//   }

//   @override
//   FutureOr onDispose() {
//     loginStatusController.close();
//     throw UnimplementedError();
//   }
// }
