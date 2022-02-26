import 'package:classroom_manager/models/Task.dart';
import 'package:classroom_manager/services/TaskService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TaskService _taskService = TaskService();
  List<Task>? tasks = [];
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  Future init() async {
    var gelenTask = await _taskService.getTasks();
    setState(() {
      tasks = gelenTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RefreshIndicator(
            onRefresh: init,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: tasks?.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(tasks?[index].title ?? 'null'),
                    subtitle: Text(tasks?[index].content ?? 'null'),
                    trailing: Text(
                        DateTime.parse(tasks?[index].createdDate ?? 'null')
                                .hour
                                .toString() +
                            ":" +
                            DateTime.parse(tasks?[index].createdDate ?? 'null')
                                .minute
                                .toString()));
              },
            ))
      ],
    );
  }
}
