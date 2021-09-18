import '../../models/user.dart';

abstract class AuthService {
  Future<User> checkCredential({String username, String password});
  Future<User> getUser();
}
