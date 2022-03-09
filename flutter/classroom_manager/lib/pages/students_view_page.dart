import 'dart:async';

import 'package:classroom_manager/widgets/info.dart';
import 'package:classroom_manager/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../blocs/student_bloc/student_bloc.dart';
import '../widgets/error.dart';

class StudentsListView extends StatelessWidget {
  const StudentsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _studentBloc = BlocProvider.of<StudentBloc>(context);
    _studentBloc.add(FetchStudentListEvent());
    return bloc(_studentBloc);
  }

  BlocBuilder<StudentBloc, Object?> bloc(StudentBloc _studentBloc) {
    Completer<void> _refreshCompleter = Completer<void>();

    return BlocBuilder(
      bloc: _studentBloc,
      buildWhen: (previous, current) => previous != current && current is StudentListLoadedState,
      builder: (context, state) {
        if (state is StudentListLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is StudentListLoadedState) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return state.students.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: () {
                    _studentBloc.add(RefreshStudentListEvent());
                    return _refreshCompleter.future;
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: listview(state),
                  ),
                )
              : const InfoMessageWidget(message: 'Hic Ogrenci Eklenmedi');
        } else if (state is StudentListErrorState) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return const ErrorMessageWidget(
            message: 'Error Olustu',
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  ListView listview(StudentListLoadedState state) {
    return ListView.builder(
        itemCount: state.students.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListItem(title: state.students[index]!.username!);
        });
  }
}
