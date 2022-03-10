import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/student.dart';
import '../../services/locator.dart';
import '../../services/student_service.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final _studentService = locator<StudentService>();
  StudentBloc() : super(StudentInitial()) {
    on<FetchStudentListEvent>(_fetchStudentListEvent);
    on<RefreshStudentListEvent>(_refreshStudentListEvent);
    on<StudentUpdateEvent>(_studentUpdateEvent);
  }

  Future<FutureOr<void>> _fetchStudentListEvent(FetchStudentListEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoadingState());
    try {
      List<Student?> students = await _studentService.getStudentList();
      emit(StudentListLoadedState(students: students));
    } catch (_) {
      emit(StudentErrorState());
    }
  }

  Future<FutureOr<void>> _refreshStudentListEvent(RefreshStudentListEvent event, Emitter<StudentState> emit) async {
    try {
      List<Student?> students = await _studentService.getStudentList();
      emit(StudentListLoadedState(students: students));
    } catch (_) {
      emit(state);
    }
  }

  Future<FutureOr<void>> _studentUpdateEvent(StudentUpdateEvent event, Emitter<StudentState> emit) async {
    emit(StudentLoadingState());
    try {
      bool updateStudentStatus = await _studentService.updateStudent(event.student.id!, event.firstName, event.lastName, event.password);
      print('deger= $updateStudentStatus');
      if (updateStudentStatus) {
        List<Student?> students = await _studentService.getStudentList();
        emit(StudentListLoadedState(students: students));
      } else {
        emit(StudentErrorState());
      }
    } catch (_) {
      emit(StudentErrorState());
    }
  }
}
