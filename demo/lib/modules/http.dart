import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestResult {
  bool checked;
  dynamic data;
  RequestResult(this.checked, this.data);
}

const PROTOCOL = 'http';
const DOMAIN = '10.0.2.2:8000';

Future<RequestResult> http_get(String route, [dynamic data]) async {
  var dataStr = jsonEncode(data);
  var url = "$PROTOCOL://$DOMAIN/$route?data=$dataStr";
  var result = await http.get(url);
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> http_post(String route, [dynamic data]) async {
  var url = "http://$DOMAIN/$route";
  var dataStr = jsonEncode(data);
  var result = await http
      .post(url, body: dataStr, headers: {'Content-Type': 'application/json'});
  return RequestResult(true, jsonDecode(result.body));
}
