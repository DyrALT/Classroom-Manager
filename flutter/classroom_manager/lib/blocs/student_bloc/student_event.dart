part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class FetchStudentListEvent extends StudentEvent {}

class RefreshStudentListEvent extends StudentEvent {}

class StudentUpdateEvent extends StudentEvent {
  final Student student;
  final String password;
  final String firstName;
  final String lastName;
  const StudentUpdateEvent({required this.firstName, required this.lastName, required this.student, required this.password});

  @override
  List<Object> get props => [student];
}

class StudentDeleteEvent extends StudentEvent {
  final Student student;
  const StudentDeleteEvent({required this.student});

    @override
  List<Object> get props => [student];
}
