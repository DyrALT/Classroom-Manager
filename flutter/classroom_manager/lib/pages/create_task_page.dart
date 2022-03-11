import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../static/texts.dart';
import '../widgets/appbar.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  var formKey = GlobalKey<FormState>();
  // ignore: unused_field
  late String _title;
  // ignore: unused_field
  late String _content;
  @override
  Widget build(BuildContext context) {
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    return Scaffold(
      appBar: MyAppBar(title: 'Create Task', appBar: AppBar(), widgets: const []),
      floatingActionButton: floatingActionButton(_taskBloc),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        _title = value!;
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
                          errorStyle: const TextStyle(fontSize: 15),
                          labelText: Texts.task_form_title,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: Colors.purple))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                          errorStyle: const TextStyle(fontSize: 15),
                          labelText: Texts.task_form_content,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: Colors.purple))),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Padding floatingActionButton(TaskBloc _taskBloc) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            _taskBloc.add(CreateTaskEvent(title: _title, content: _content));
            Navigator.pop(context);
          }
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 83, 173, 173),
            boxShadow: const [
              BoxShadow(color: Color.fromARGB(255, 80, 168, 168), spreadRadius: 3),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                Texts.task_create,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
