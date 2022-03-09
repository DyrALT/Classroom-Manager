part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class StudentListLoadingState extends StudentState {}

class StudentListLoadedState extends StudentState {
  final List<Student?> students;
  const StudentListLoadedState({required this.students});
    @override
  List<Object> get props => [students];
}

class StudentListErrorState extends StudentState {}
