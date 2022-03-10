import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/student.dart';
import '../static/urls.dart';
import 'auth.dart';
import 'locator.dart';

class StudentService {
  final _auth = locator<Auth>();

  updateStudent(int id, String firstName, String lastName, String password) async {
    var token = await _auth.getToken();

    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(Urls.mainUrl + Urls.updateStudent));
    request.body = json.encode({"studentId": id, "firstName": firstName, "lastName": lastName, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  getStudentList() async {
    var token = await _auth.getToken();

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse(Urls.mainUrl + Urls.listStudent));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var obj = json.decode(await response.stream.bytesToString());
      List<Student?> students = [];
      students.addAll((obj as List).map((e) => Student.fromJson(e)).toList());
      return students;
    } else {
      print(response.reasonPhrase);
    }
  }
}
