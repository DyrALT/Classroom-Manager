import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../static/urls.dart';

class Auth {
  final storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    String? token = await storage.read(key: 'access');
    return token;
  }

  Future<String?> getRefreshToken() async {
    String? token = await storage.read(key: 'refresh');
    return token;
  }

  verifyToken() async {
    String? token = await getToken();
    if (token == null) {
      return false;
    } else {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(Urls.mainUrl+ Urls.verifyToken));
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
    String? refresh = await getRefreshToken();
    if (refresh == null) {
      return false;
    } else {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(Urls.mainUrl+ Urls.resfreshToken));
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
    String? access = await getToken();
    String? refresh = await getRefreshToken();
    print('''
  acces : $access
  refresh : $refresh
''');
    var tokenStatus = await verifyToken();
    if (tokenStatus) {
      //token hala gecerli giris yapilabilir
      return true;
    } else {
      var refreshTokenStatus = await refreshToken(); //refresh token ile yeni token alinacak
      if (refreshTokenStatus) {
        return true;
      } else {
        return false;
      }
    }
  }

  verifyAuth() async {
    var verify_token = await verifyToken();
    if (verify_token == false) {
      var refresh_token = await refreshToken();
      if (refresh_token == false) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  loginWithUsernamePassword(String username, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(Urls.mainUrl+ Urls.tokenUrl));
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
