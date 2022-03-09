import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../models/task.dart';
import '../widgets/error.dart';
import '../widgets/info.dart';
import '../widgets/list_item.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Completer<void> _refreshCompleter = Completer<void>();
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    _taskBloc.add(FetchTaskListEvent());
    return bloc(_taskBloc, _refreshCompleter);
  }

  BlocBuilder<TaskBloc, TaskState> bloc(TaskBloc _taskBloc, Completer<void> _refreshCompleter) {
    return BlocBuilder<TaskBloc, TaskState>(
      bloc: _taskBloc,
      buildWhen: (previous, current) => previous != current && current is TaskListLoadedState,
      builder: (context, state) {
        if (state is TaskListLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TaskListLoadedState) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return state.tasks.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: () {
                    _taskBloc.add(RefreshTaskListEvent());
                    return _refreshCompleter.future;
                  },
                  child: SizedBox(
                      child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: listview(state),
                  )))
              : const InfoMessageWidget(message: 'Hic Task Eklenmedi');
        } else if (state is TaskListErrorState) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return const ErrorMessageWidget(
            message: 'Hata Olustu',
          );
        } else {
          return const SizedBox();
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
