import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/task.dart';
import '../../services/locator.dart';
import '../../services/task_service.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final _taskService = locator<TaskService>();
  TaskBloc() : super(TaskInitial()) {
    on<FetchTaskListEvent>(_fetchTaskList);
    on<RefreshTaskListEvent>(_refreshTaskList);
  }

  Future<FutureOr<void>> _fetchTaskList(FetchTaskListEvent event, Emitter<TaskState> emit) async {
    emit(TaskListLoadingState());
    try {
      List<Task?> tasks = await _taskService.getTaskList();
      emit(TaskListLoadedState(tasks: tasks));
    } catch (_) {
      emit(TaskListErrorState());
    }
  }

  Future<FutureOr<void>> _refreshTaskList(RefreshTaskListEvent event, Emitter<TaskState> emit) async {
    try {
      List<Task?> tasks = await _taskService.getTaskList();
      emit(TaskListLoadedState(tasks: tasks));
    } catch (_) {
      emit(state);
    }
  }
}
