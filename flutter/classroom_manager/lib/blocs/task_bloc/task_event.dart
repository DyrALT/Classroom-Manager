part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class FetchTaskListEvent extends TaskEvent {}

class RefreshTaskListEvent extends TaskEvent {}

class FetchTaskDetailEvent extends TaskEvent {
  final int id;
  const FetchTaskDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class RefreshTaskDetailEvent extends TaskEvent {
  final int id;
  const RefreshTaskDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class CreateTaskEvent extends TaskEvent {
  final String title;
  final String content;
  const CreateTaskEvent({required this.title, required this.content});

  @override
  List<Object> get props => [title, content];
}

class DeleteTaskEvent extends TaskEvent {
  final int id;
  const DeleteTaskEvent({required this.id});

  @override
  List<Object> get props => [id];
}
