import '../../app/dependencies.dart';
import '../../models/user.dart';
import '../rest.dart';
import 'auth_service.dart';

class AuthServiceRest implements AuthService {
  RestService get rest => dependency();

  Future<User> checkCredential({String username, String password}) async {
    final json = await rest
        .post("auth/login", data: {'username': username, 'password': password});
    if (json == null) return null;
    return User.fromJson(json);
  }

  @override
  Future<User> getUser() async {
    final json = await rest.get("auth");
    return User.fromJson(json);
  }
}
