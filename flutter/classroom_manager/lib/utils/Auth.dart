import 'dart:convert';

import 'package:http/http.dart' as http;

class Auth {
  login(String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://127.0.0.1:8000/api/token/'));
    request.body = json.encode({"username": email, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // var obj = await response.stream.bytesToString();
      return response;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
}
