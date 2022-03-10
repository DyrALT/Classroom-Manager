part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoadingState extends StudentState {}

class StudentListLoadedState extends StudentState {
  final List<Student?> students;
  const StudentListLoadedState({required this.students});
  @override
  List<Object> get props => [students];
}

class StudentDetailState extends StudentState {
  final Student student;
  const StudentDetailState({required this.student});
  @override
  List<Object> get props => [student];
}

class StudentErrorState extends StudentState {}
