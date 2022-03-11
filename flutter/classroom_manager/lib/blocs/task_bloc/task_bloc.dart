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
    on<CreateTaskEvent>(_createTaskEvent);
    on<DeleteTaskEvent>(_deleteTaskEvent);
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

  Future<FutureOr<void>> _createTaskEvent(CreateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      bool createTaskStatus = await _taskService.createTask(event.title, event.content);
      if (createTaskStatus) {
        List<Task?> tasks = await _taskService.getTaskList();
        emit(TaskListLoadedState(tasks: tasks));
      } else {
        emit(TaskErrorState());
      }
    } catch (_) {
      emit(TaskErrorState());
    }
  }

  Future<FutureOr<void>> _deleteTaskEvent(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      bool createTaskStatus = await _taskService.deleteTask(event.id);
      if (createTaskStatus) {
        List<Task?> tasks = await _taskService.getTaskList();
        emit(TaskListLoadedState(tasks: tasks));
      } else {
        emit(TaskErrorState());
      }
    } catch (_) {
      emit(TaskErrorState());
    }
  }
}
