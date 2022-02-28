import 'package:classroom_manager/models/Student.dart';
import 'package:classroom_manager/services/Auth.dart';
import 'package:classroom_manager/static/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentService {
  Auth _auth = Auth();

  getStudents() async {
    String? token = await _auth.getToken();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.http(Urls.mainUrl, Urls.listStudent));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var obj = json.decode(await response.stream.bytesToString());
      List<Student> students = [];
      students.addAll((obj as List).map((e) => Student.fromJson(e)).toList());
      return students;
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

  createStudent(String firstName, String lastName, String password) async {
    String? token = await _auth.getToken();
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.http(Urls.mainUrl, Urls.createStudent));
    request.body = json.encode(
        {"firstName": firstName, "lastName": lastName, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  updateStudent(String student_id, String firstName, String lastName,
      String password) async {
    String? token = await _auth.getToken();

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.http(Urls.mainUrl, Urls.updateStudent));
    request.body = json.encode({
      "student_id": student_id,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
