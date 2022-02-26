import 'package:classroom_manager/models/Student.dart';
import 'package:classroom_manager/services/Auth.dart';
import 'package:classroom_manager/static/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentService {
  Auth _auth = Auth();

  getStudents() async {
    String? token = await _auth.getToken();
    var headers = {
      'Authorization':
          'Bearer $token'
    };
    var request = http.Request(
        'GET', Uri.http(Urls.mainUrl,Urls.listStudent));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var obj = json.decode(await response.stream.bytesToString());
      List<Student> students = [];
      students
          .addAll((obj as List).map((e) => Student.fromJson(e)).toList());
      return students;
    } else {
      print(response.reasonPhrase);
    }
  }
}
