
import 'package:flutter/material.dart';

import '../widgets/appbar.dart';

class CreateStudentPage extends StatefulWidget {
  const CreateStudentPage({ Key? key }) : super(key: key);

  @override
  State<CreateStudentPage> createState() => _CreateStudentPageState();
}

class _CreateStudentPageState extends State<CreateStudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Classroom Manager', appBar: AppBar(), widgets: const [])
    );
  }
}