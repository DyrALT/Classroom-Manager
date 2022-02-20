import 'package:flutter/material.dart';

class StudentsWidget extends StatefulWidget {
  const StudentsWidget({Key? key}) : super(key: key);

  @override
  _StudentsWidgetState createState() => _StudentsWidgetState();
}

class _StudentsWidgetState extends State<StudentsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('students')],
    );
  }
}
