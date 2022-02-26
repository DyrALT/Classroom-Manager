import 'package:classroom_manager/models/Student.dart';
import 'package:classroom_manager/services/StudentService.dart';
import 'package:flutter/material.dart';

class StudentsWidget extends StatefulWidget {
  const StudentsWidget({Key? key}) : super(key: key);

  @override
  _StudentsWidgetState createState() => _StudentsWidgetState();
}

class _StudentsWidgetState extends State<StudentsWidget> {
  StudentService _studentService = StudentService();
  List<Student>? students = [];
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  Future init() async {
    var gelenStudent = await _studentService.getStudents();
    setState(() {
      students = gelenStudent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RefreshIndicator(
            onRefresh: init,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: students?.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(students?[index].username ?? 'null'),
                );
              },
            ))
      ],
    );
  }
}
