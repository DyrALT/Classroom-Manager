import 'dart:convert';
import 'package:classroom_manager/static/urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth {
  final storage = FlutterSecureStorage();

  verifyToken() async {
    String? token = await storage.read(key: 'access');
    if (token == null) {
      return false;
    } else {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.http(Urls.mainUrl, Urls.verifyToken));
      request.body = json.encode({"token": token});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 401) {
        return false;
      }
    }
  }

  refreshToken() async {
    String? refresh = await storage.read(key: 'refresh');
    if (refresh == null) {
      return false;
    } else {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.http(Urls.mainUrl, Urls.resfreshToken));
      request.body = json.encode({"refresh": refresh});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var obj = json.decode(await response.stream.bytesToString());
        await storage.write(key: 'access', value: obj['access']);
        return true;
      }
      if (response.statusCode == 401) {
        return false;
      }
    }
  }

  getLogin() async {
    String? access = await storage.read(key: 'access');
    String? refresh = await storage.read(key: 'refresh');
    print('''
  acces : $access
  refresh : $refresh
''');
    var token_status = await verifyToken();
    if (token_status == true) {
      //token hala gecerli giris yapilabilir
      return true;
    } else {
      var refresh_token_status = await
          refreshToken(); //refresh token ile yeni token alinacak
      if (refresh_token_status == true) {
        return true;
      } else {

        return false;
      }
    }
  }

  loginWithToken() async {}
  loginWithUsernamePassword(String username, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.http(Urls.mainUrl, Urls.tokenUrl));
    request.body = json.encode({"username": username, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var obj = json.decode(await response.stream.bytesToString());
      await storage.write(key: 'access', value: obj['access']);
      await storage.write(key: 'refresh', value: obj['refresh']);
      return obj;
    } else {
      return false;
    }
  }
}
