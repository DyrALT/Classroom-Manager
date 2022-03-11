import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/student_bloc/student_bloc.dart';
import '../static/texts.dart';
import '../widgets/appbar.dart';

class CreateStudentPage extends StatefulWidget {
  const CreateStudentPage({Key? key}) : super(key: key);

  @override
  State<CreateStudentPage> createState() => _CreateStudentPageState();
}

class _CreateStudentPageState extends State<CreateStudentPage> {
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
      appBar: MyAppBar(title: 'Create Student', appBar: AppBar(), widgets: const []),
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
            _studentBloc.add(StudentCreateEvent(firstName: _firstName, lastName: _lastName, password: _password));
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
                Texts.student_create,
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
          if (value!.isEmpty) {
            return Texts.required_to_be_filled;
          } else {
            if (value.length < 6 && value.isNotEmpty) {
              return Texts.required_to_six_character;
            } else {
              return null;
            }
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
}
