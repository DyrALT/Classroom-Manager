import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/Student.dart';
import '../pages/login.dart';

class StudentsWidget extends StatefulWidget {
  const StudentsWidget({Key? key}) : super(key: key);

  @override
  _StudentsWidgetState createState() => _StudentsWidgetState();
}

class _StudentsWidgetState extends State<StudentsWidget> {
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [RefreshIndicator(onRefresh: () => Future.delayed(const Duration(seconds: 3)), child: Text('data'))],
    );
  }
}
