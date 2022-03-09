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
