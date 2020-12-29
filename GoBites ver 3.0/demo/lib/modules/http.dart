import 'package:http/http.dart' as http;

class RequestResult {
  bool checked;
  dynamic data;
  RequestResult(this.checked, this.data);
}

const PROTOCOL = 'http';
const DOMAIN = 'go-bites-server.herokuapp.com/mobile/api';

Future<http.Response> http_get(String route) async {
  //var dataStr = jsonEncode(data);
  var url = "http://$DOMAIN$route";
  var result = await http.get(url);
  return result;
}

Future<http.Response> http_post(String route, [dynamic data]) async {
  var url = "http://$DOMAIN$route";
  //var dataStr = jsonEncode(data);
  var result = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: data);
  return result;
}
