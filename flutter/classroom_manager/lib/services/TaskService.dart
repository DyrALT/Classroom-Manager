import 'dart:convert';

import 'package:classroom_manager/models/Task.dart';
import 'package:classroom_manager/services/Auth.dart';
import 'package:classroom_manager/static/urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TaskService {
  Auth _auth = Auth();
  getTasks() async {
    String? token = await _auth.getToken();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.http(Urls.mainUrl, Urls.listTask));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      List<Task> tasks = [];
      var obj = json.decode(await response.stream.bytesToString());
      tasks
          .addAll((obj['tasks'] as List).map((e) => Task.fromJson(e)).toList());
      return tasks;
    } else {
      print(response.reasonPhrase);
      var auth = await _auth.verifyAuth();
      if (auth) {
        return null;
      } else {
        return false;
      }
    }
  }

  refreshTask(int id) async {
    String? token = await _auth.getToken();
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.http(Urls.mainUrl, Urls.detailTask));
    request.body = json.encode({"id": id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      return Task.fromJson(jsonResponse);
    } else {
      print(response.reasonPhrase);
      var auth = await _auth.verifyAuth();
      if (auth) {
        return null;
      } else {
        return false;
      }
    }
  }

  createTask(String title, String content) async {
    String? token = await _auth.getToken();
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.http(Urls.mainUrl, Urls.createTask));
    request.body = json.encode({"title": title, "content": content});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.reasonPhrase);
      var auth = await _auth.verifyAuth();
      if (auth) {
        return null;
      } else {
        return false;
      }
    }
  }
}
