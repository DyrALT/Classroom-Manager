part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskListLoadedState extends TaskState {
  final List<Task?> tasks;
  const TaskListLoadedState({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskErrorState extends TaskState {}

class TaskDetailLoadedState extends TaskState {
  final Task task;
  const TaskDetailLoadedState({required this.task});

    @override
  List<Object> get props => [task];
}
