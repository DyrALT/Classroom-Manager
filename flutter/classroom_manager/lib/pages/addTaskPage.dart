import 'package:flutter/material.dart';

import '../services/TaskService.dart';
import '../static/texts.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  var formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;
  TaskService _taskService = new TaskService();
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
            'Add Task',
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
        body: Column(children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      onSaved: (newValue) {
                        setState(() {
                          _title = newValue!;
                        });
                      },
                      autofocus: false,
                      validator: (value) {
                        if (value!.replaceAll(' ', '') == '') {
                          return Texts.required_to_be_filled;
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 15),
                          labelText: Texts.task_form_title,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(width: 1, color: Colors.purple))),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved: (value) {
                        _content = value!;
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
                          labelText: Texts.task_form_content,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(width: 1, color: Colors.purple))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            bool taskStatus = await _taskService.createTask(_title, _content);
                            if (taskStatus) {
                              Navigator.of(context).pop();
                            } else {
                              const snackBar = SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(Texts.task_create_error),
                                backgroundColor: (Colors.black54),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }
                        },
                        child: Text('Olustur'))
                  ],
                ),
              ))
        ]));
  }
}
