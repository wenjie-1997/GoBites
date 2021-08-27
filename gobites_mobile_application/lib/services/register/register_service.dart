import 'package:gobites/models/restaurant.dart';

abstract class RegisterSevice {
  Future<bool> checkUsername(String username);
  Future<dynamic> register(dynamic data);
}
