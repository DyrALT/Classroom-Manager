import 'package:classroom_manager/models/Task.dart';
import 'package:classroom_manager/pages/login.dart';
import 'package:classroom_manager/pages/taskDetailPage.dart';
import 'package:classroom_manager/services/TaskService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TaskService _taskService = TaskService();
  final storage = FlutterSecureStorage();

  List<Task>? tasks = [];
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  Future init() async {
    var gelenTask = await _taskService.getTasks();
    if (gelenTask == false) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (r) => false);
      });
    } else if (gelenTask == null) {
      init();
    } else {
      setState(() {
        tasks = gelenTask;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: init,
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
              itemCount: tasks?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(tasks?[index].title ?? 'null'),
                  subtitle: Text(tasks?[index].content ?? 'null',
                      overflow: TextOverflow.ellipsis),
                  trailing: Text(
                      DateTime.parse(tasks?[index].createdDate ?? 'null')
                              .hour
                              .toString() +
                          ":" +
                          DateTime.parse(tasks?[index].createdDate ?? 'null')
                              .minute
                              .toString()
                              .padLeft(2, "0")),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TaskDetailPage(
                          task_id: tasks![index].id!, task_: tasks![index]),
                    ));
                  },
                );
              },
            )));
  }
}
