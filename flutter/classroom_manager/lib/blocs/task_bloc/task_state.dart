part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskListLoadingState extends TaskState {}

class TaskListLoadedState extends TaskState {
  final List<Task?> tasks;
  const TaskListLoadedState({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskListErrorState extends TaskState {}
