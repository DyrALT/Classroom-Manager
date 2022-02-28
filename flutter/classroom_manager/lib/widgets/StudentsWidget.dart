import 'package:classroom_manager/models/Student.dart';
import 'package:classroom_manager/pages/login.dart';
import 'package:classroom_manager/pages/studentDetailPage.dart';
import 'package:classroom_manager/services/StudentService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StudentsWidget extends StatefulWidget {
  const StudentsWidget({Key? key}) : super(key: key);

  @override
  _StudentsWidgetState createState() => _StudentsWidgetState();
}

class _StudentsWidgetState extends State<StudentsWidget> {
  StudentService _studentService = StudentService();
  final storage = FlutterSecureStorage();

  List<Student>? students = [];
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  Future init() async {
    var gelenStudent = await _studentService.getStudents();
    if (gelenStudent == false) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (r) => false);
      });
    } else if (gelenStudent != null) {
      setState(() {
        students = gelenStudent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RefreshIndicator(
            onRefresh: init,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
              shrinkWrap: true,
              itemCount: students?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(students?[index].username ?? 'null'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StudentDetailPage(student: students![index],),
                    ));
                  },
                );
              },
            ))
      ],
    );
  }
}
