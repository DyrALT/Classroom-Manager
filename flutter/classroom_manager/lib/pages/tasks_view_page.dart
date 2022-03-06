import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../models/task.dart';
import '../widgets/list_item.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Completer<void> _refreshCompleter = Completer<void>();
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    _taskBloc.add(FetchTaskListEvent());
    return BlocBuilder<TaskBloc, TaskState>(
      bloc: _taskBloc,
      builder: (context, state) {
        if (state is TaskListLoadedState) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return RefreshIndicator(
              onRefresh: () {
                _taskBloc.add(RefreshTaskListEvent());
                return _refreshCompleter.future;
              },
              child: SizedBox(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: listview(state),
              )));
        } else if (state is TaskListErrorState) {
          return const Text('error olustu');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView listview(TaskListLoadedState state) {
    return ListView.builder(
        itemCount: state.tasks.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListItem(
            title: state.tasks[index]!.title!,
            subtitle: state.tasks[index]!.content!,
            date: state.tasks[index]!.createdDate,
            onTap: () {
              print('basildi');
            },
          );
        });
  }
}
