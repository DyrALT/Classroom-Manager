import 'package:classroom_manager/services/StudentService.dart';
import 'package:classroom_manager/static/texts.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
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
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Add Student',
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.purple))),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextFormField(
                        onSaved: (value) {
                          _lastName = value!;
                        },
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
                            labelText: Texts.student_form_lastname_title,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.purple))),
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
                    if (value!.replaceAll(' ', '') == '') {
                      return Texts.required_to_be_filled;
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      errorStyle: TextStyle(fontSize: 15),
                      labelText: Texts.student_form_password_title,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              BorderSide(width: 1, color: Colors.purple))),
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
                  var student = await _studentService.createStudent(
                      _firstName, _lastName, _password);
                  if (student) {
                    Navigator.of(context).pop();
                  } else {
                    const snackBar = SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text(Texts.student_create_error),
                      backgroundColor: (Colors.black54),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              },
              child: Text('Olustur'))
        ],
      ),
    );
  }
}
