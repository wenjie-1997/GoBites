// import 'package:gobites/models/user.dart';

abstract class RegisterSevice {
  Future<bool> checkUsername(String username);
  Future<dynamic> register(dynamic data);
}
