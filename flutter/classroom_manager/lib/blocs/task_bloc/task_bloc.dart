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
    on<FetchTaskDetailEvent>(_fetchTaskDetail);
    on<RefreshTaskDetailEvent>(_refreshTaskDetail);
  }

  Future<FutureOr<void>> _fetchTaskList(FetchTaskListEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      List<Task?> tasks = await _taskService.getTaskList();
      emit(TaskListLoadedState(tasks: tasks));
    } catch (_) {
      emit(TaskErrorState());
    }
  }

  Future<FutureOr<void>> _refreshTaskList(RefreshTaskListEvent event, Emitter<TaskState> emit) async {
    try {
      List<Task?> tasks = await _taskService.getTaskList();
      emit(TaskListLoadedState(tasks: tasks));
    } catch (_) {
      emit(TaskErrorState());
    }
  }

  Future<FutureOr<void>> _fetchTaskDetail(FetchTaskDetailEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      Task task = await _taskService.taskDetail(event.id);
      emit(TaskDetailLoadedState(task: task));
    } catch (_) {
      emit(TaskErrorState());
    }
  }

  Future<FutureOr<void>> _refreshTaskDetail(RefreshTaskDetailEvent event, Emitter<TaskState> emit) async {
    try {
      Task task = await _taskService.taskDetail(event.id);
      emit(TaskDetailLoadedState(task: task));
    } catch (_) {
      emit(TaskErrorState());
    }
  }
}
