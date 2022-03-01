import 'package:classroom_manager/models/Task.dart';
import 'package:classroom_manager/pages/login.dart';
import 'package:classroom_manager/services/TaskService.dart';
import 'package:classroom_manager/static/texts.dart';
import 'package:classroom_manager/widgets/TasksWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TaskDetailPage extends StatefulWidget {
  late int task_id;
  late Task task_;
  TaskDetailPage({Key? key, required this.task_id, required this.task_})
      : super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  TaskService _taskService = TaskService();
  final storage = FlutterSecureStorage();
  late Task task;
  @override
  void initState() {
    task = widget.task_;
    init();
    super.initState();
  }

  init() async {
    var gelenTask = await _taskService.refreshTask(widget.task_id);
    if (gelenTask == false) {
      await storage.deleteAll();
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (r) => false);
      });
    } else if (gelenTask != null) {
      setState(() {
        task = gelenTask;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          task.title!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(onPressed: delete, icon: Icon(Icons.delete)))
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.cyan.shade800,
            Colors.cyan.shade500,
            Colors.cyan.shade400,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        ),
      ),
      body: RefreshIndicator(
          onRefresh: refresh,
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [
                            Text(
                              task.finished!.length.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 35,
                                  color: Colors.green),
                            ),
                            Text('Yapanlar')
                          ]),
                          Column(children: [
                            Text(
                              task.unfinished!.length.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 35,
                                  color: Colors.red),
                            ),
                            Text('Yapamayanlar')
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          task.content!,
                          style: TextStyle(fontSize: 15),
                        )),
                    SizedBox(height: 30),
                    Divider(),
                    Text('Yapanlar', style: TextStyle(fontSize: 25)),
                    SizedBox(height: 20),
                    Column(
                      children: <Widget>[
                        for (var item in task.finished!)
                          Text(item.username!, style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    SizedBox(height: 30),
                    Divider(),
                    Text('Yapmayanlar', style: TextStyle(fontSize: 25)),
                    SizedBox(height: 20),
                    Column(
                      children: <Widget>[
                        for (var item in task.unfinished!) Text(item.username!)
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }

  Future<void> refresh() async {
    var gelenTask = (await _taskService.refreshTask(widget.task_id));
    if (gelenTask == false) {
      await storage.deleteAll();
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (r) => false);
      });
    } else if (gelenTask != null) {
      setState(() {
        task = gelenTask;
      });
    } else {}
  }

  delete() {
    return showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        title: Text("Silmek İstediğinize Emin Misiniz"),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              var status = await _taskService.deleteTask(task.id.toString());
              if (status) {
                Navigator.of(context, rootNavigator: true).pop(context);
                Navigator.of(context).pop();
              } else {
                Navigator.of(context, rootNavigator: true).pop(context);
                const snackBar = SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text(Texts.task_delete_error),
                  backgroundColor: (Colors.black54),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Text("EVET"),
          ),
        ],
      ),
    );
  }
}
