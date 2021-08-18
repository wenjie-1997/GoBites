import 'package:gobites/app/dependencies.dart';
// import 'package:gobites/models/user.dart';
import 'package:gobites/services/register/register_service.dart';

import '../rest.dart';

class RegisterServiceRest implements RegisterSevice {
  RestService get rest => dependency();

  Future<bool> checkUsername(String username) async {
    final json =
        await rest.post('user/check_username', data: {'username': username});
    return json['exist'];
  }

  @override
  Future<dynamic> register(dynamic data) async {
    final json = await rest.post('user/register', data: data);
    return json;
  }
}
