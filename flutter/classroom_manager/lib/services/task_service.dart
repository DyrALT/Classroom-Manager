import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/task.dart';
import '../static/urls.dart';
import 'auth.dart';
import 'locator.dart';

class TaskService {
  final _auth = locator<Auth>();
  getTaskList() async {
    var token = await _auth.getToken();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse(Urls.mainUrl + Urls.listTask));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var obj = json.decode(await response.stream.bytesToString());
      List<Task?> tasks = [];
      tasks.addAll((obj['tasks'] as List).map((e) => Task.fromJson(e)).toList());
      print('cagrildi');
      return tasks;
    } else {
      print(response.reasonPhrase);
      List<Task?> tasks = [];
      return tasks;
    }
  }
}
