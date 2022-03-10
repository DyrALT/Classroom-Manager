import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/student_bloc/student_bloc.dart';
import '../models/student.dart';
import '../static/texts.dart';
import '../widgets/appbar.dart';

class StudentDetailsPage extends StatefulWidget {
  late Student student;

  StudentDetailsPage({Key? key, required this.student}) : super(key: key);

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  var formKey = GlobalKey<FormState>();
  // ignore: unused_field
  late String _firstName;
  // ignore: unused_field
  late String _lastName;
  // ignore: unused_field
  String _password = '';
  @override
  Widget build(BuildContext context) {
    final _studentBloc = BlocProvider.of<StudentBloc>(context);
    return Scaffold(
      appBar: MyAppBar(title: widget.student.username!, appBar: AppBar(), widgets: [
        IconButton(
            onPressed: () {
              stuentDelete(_studentBloc);
            },
            icon: const Icon(Icons.delete))
      ]),
      floatingActionButton: floatingActionButton(_studentBloc),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                nameFields(),
                passField(),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Padding floatingActionButton(StudentBloc _studentBloc) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            _studentBloc.add(StudentUpdateEvent(student: widget.student, password: _password, firstName: _firstName, lastName: _lastName));
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
                Texts.student_upgrade,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding passField() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        onSaved: (value) {
          _password = value!;
        },
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value) {
          if (value!.isNotEmpty) {
            if (value.replaceAll(' ', '') == '') {
              return Texts.required_to_be_filled;
            } else {
              return null;
            }
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 15),
            labelText: Texts.student_form_password_title,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: Colors.purple))),
      ),
    );
  }

  Padding nameFields() {
    return Padding(
      padding: const EdgeInsets.all(15),
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
                  errorStyle: const TextStyle(fontSize: 15),
                  labelText: Texts.student_form_firstname_title,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: Colors.purple))),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: TextFormField(
              onSaved: (value) {
                _lastName = value!;
              },
              controller: TextEditingController(text: widget.student.lastName),
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
                  labelText: Texts.student_form_lastname_title,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(width: 1, color: Colors.purple))),
            ),
          ),
        ],
      ),
    );
  }

  stuentDelete(StudentBloc _studentBloc) {
    return showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        title: const Text("Emin Misiniz?"),
        content: const Text('Bu Ogrenciyi silmek istediginize emin misiniz?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              _studentBloc.add(StudentDeleteEvent(student: widget.student));
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("EVET"),
          ),
        ],
      ),
    );
  }
}
