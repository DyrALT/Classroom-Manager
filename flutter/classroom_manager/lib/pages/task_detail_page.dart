import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../models/task.dart';
import '../widgets/appbar.dart';
import '../widgets/error.dart';

class TaskDetailsPage extends StatefulWidget {
  final String title;
  const TaskDetailsPage({Key? key, required this.title}) : super(key: key);

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    Completer<void> _refreshCompleter = Completer<void>();

    return Scaffold(
      appBar: MyAppBar(title: widget.title, appBar: AppBar(), widgets: [
        BlocBuilder<TaskBloc, TaskState>(
          bloc: _taskBloc,
          builder: (context, state) {
            if (state is TaskDetailLoadedState) {
              return IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (builder) => AlertDialog(
                        title: const Text("Emin Misiniz?"),
                        content: const Text('Bu gorevi silmek istediginize emin misiniz?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                      _taskBloc.add(DeleteTaskEvent(id: state.task.id!));

                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("EVET"),
                          ),
                        ],
                      ),
                    );

                  },
                  icon: const Icon(Icons.delete));
            } else {
              return const SizedBox();
            }
          },
        )
      ]),
      body: BlocBuilder<TaskBloc, TaskState>(
        bloc: _taskBloc,
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TaskDetailLoadedState) {
            _refreshCompleter.complete();
            _refreshCompleter = Completer();
            return RefreshIndicator(
                onRefresh: () {
                  _taskBloc.add(RefreshTaskDetailEvent(id: state.task.id!));
                  return _refreshCompleter.future;
                },
                child: SingleChildScrollView(physics: const AlwaysScrollableScrollPhysics(), child: column(state.task)));
          }
          if (state is TaskErrorState) {
            _refreshCompleter.complete();
            _refreshCompleter = Completer();
            return const ErrorMessageWidget(
              message: 'Hata Olustu',
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  SizedBox column(Task task) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          statistic(task),
          const SizedBox(
            height: 15,
          ),
          content(task),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
          studentList(task)
        ],
      ),
    );
  }

  Padding studentList(Task task) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('Yapanlar', style: TextStyle(fontSize: 25, color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: <Widget>[
              for (var item in task.finished!) Text(item.username!, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('Yapmayanlar', style: TextStyle(fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: <Widget>[
              for (var item in task.unfinished!)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 40, 10),
                  child: Text(
                    item.username!,
                    style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }

  Padding content(Task task) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        task.content!,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }

  Padding statistic(Task task) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(children: [
            Text(
              task.finished!.length.toString(),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 35, color: Colors.green),
            ),
            const Text('Yapanlar')
          ]),
          Column(children: [
            Text(
              task.unfinished!.length.toString(),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 35, color: Colors.red),
            ),
            const Text('Yapamayanlar')
          ]),
        ],
      ),
    );
  }
}
