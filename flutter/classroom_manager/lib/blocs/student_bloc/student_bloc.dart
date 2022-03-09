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
  }

  Future<FutureOr<void>> _fetchStudentListEvent(FetchStudentListEvent event, Emitter<StudentState> emit) async {
    emit(StudentListLoadingState());
    try {
      List<Student?> students = await _studentService.getStudentList();
      emit(StudentListLoadedState(students: students));
    } catch (_) {
      emit(StudentListErrorState());
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
}
