import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/Task.dart';
import '../pages/login.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  final storage = const FlutterSecureStorage();

  List<Task>? tasks = [];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: () => Future.delayed(Duration(seconds: 3)), child: SizedBox(height: MediaQuery.of(context).size.height, child: Text('datas')));
  }
}
