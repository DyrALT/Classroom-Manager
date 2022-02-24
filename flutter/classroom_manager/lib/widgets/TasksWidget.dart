import 'package:classroom_manager/models/Task.dart';
import 'package:classroom_manager/services/TaskService.dart';
import 'package:flutter/material.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TaskService _taskService = TaskService();
  List<Task> tasks = [];
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  init() async {
    tasks = await _taskService.getTasks();
    print(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(tasks[index].title ?? 'null'),
              subtitle: Text(tasks[index].content ?? 'null'),
            );
          },
        )
      ],
    );
  }
}
