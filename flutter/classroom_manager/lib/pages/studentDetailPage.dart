import 'package:flutter/material.dart';

import '../models/Student.dart';
import '../services/StudentService.dart';
import '../static/texts.dart';

class StudentDetailPage extends StatefulWidget {
  late Student student;
  StudentDetailPage({Key? key, required this.student}) : super(key: key);

  @override
  _StudentDetailPageState createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  var formKey = GlobalKey<FormState>();
  StudentService _studentService = StudentService();
  late String _firstName;
  late String _lastName;
  late String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        actions: [Padding(padding: EdgeInsets.fromLTRB(0, 0, 15, 0), child: IconButton(onPressed: delete, icon: Icon(Icons.delete)))],
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          widget.student.username!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.cyan.shade800,
            Colors.cyan.shade500,
            Colors.cyan.shade400,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Form(
            key: formKey,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        onSaved: (value) {
                          _firstName = value!;
                        },
                        controller: TextEditingController(text: widget.student.firstName),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.replaceAll(' ', '') == '') {
                            return Texts.required_to_be_filled;
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            errorStyle: TextStyle(fontSize: 15),
                            labelText: Texts.student_form_firstname_title,
                            border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(width: 1, color: Colors.purple))),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextFormField(
                        onSaved: (value) {
                          _lastName = value!;
                        },
                        keyboardType: TextInputType.text,
                        controller: TextEditingController(text: widget.student.lastName),
                        validator: (value) {
                          if (value!.replaceAll(' ', '') == '') {
                            return Texts.required_to_be_filled;
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            errorStyle: TextStyle(fontSize: 15),
                            labelText: Texts.student_form_lastname_title,
                            border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(width: 1, color: Colors.purple))),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  onSaved: (value) {
                    _password = value!;
                  },
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.length < 6 && value.length > 0) {
                      return Texts.required_to_six_character;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      errorStyle: TextStyle(fontSize: 15),
                      labelText: Texts.student_form_password_title,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(width: 1, color: Colors.purple))),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  var data = await _studentService.updateStudent(widget.student.id.toString(), _firstName, _lastName, _password);
                  if (data) {
                    Navigator.of(context).pop();
                  } else {
                    const snackBar = SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text(Texts.student_update_error),
                      backgroundColor: (Colors.black54),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              },
              child: Text('Guncelle'))
        ],
      ),
    );
  }

  delete() {
    return showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        title: Text("Silmek İstediğinize Emin Misiniz"),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              var status = await _studentService.deleteStudent(widget.student.id.toString());
              if (status) {
                Navigator.of(context, rootNavigator: true).pop(context);
                Navigator.of(context).pop();
              } else {
                Navigator.of(context, rootNavigator: true).pop(context);
                const snackBar = SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text(Texts.student_delete_error),
                  backgroundColor: (Colors.black54),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Text("EVET"),
          ),
        ],
      ),
    );
  }
}
