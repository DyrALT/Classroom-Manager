import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/student.dart';
import '../static/urls.dart';
import 'auth.dart';
import 'locator.dart';

class StudentService {
  final _auth = locator<Auth>();

  createStudent(String firstName, String lastName, String password) async {
    var token = await _auth.getToken();

    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(Urls.mainUrl + Urls.createStudent));
    request.body = json.encode({"firstName": firstName, "lastName": lastName, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  deleteStudent(int id) async {
    var token = await _auth.getToken();
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(Urls.mainUrl + Urls.deleteStudent));
    request.body = json.encode({"studentId": id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  updateStudent(int id, String firstName, String lastName, String password) async {
    var token = await _auth.getToken();

    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(Urls.mainUrl + Urls.updateStudent));
    request.body = json.encode({"studentId": id, "firstName": firstName, "lastName": lastName, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      // ignore: avoid_print
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
      // ignore: avoid_print
      print(response.reasonPhrase);
    }
  }
}
