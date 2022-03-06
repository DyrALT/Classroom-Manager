import 'package:classroom_manager/services/task_service.dart';
import 'package:classroom_manager/services/auth.dart';
import 'package:get_it/get_it.dart';

import '../blocs/login_bloc/login_bloc.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator()async {
  locator.registerLazySingleton(() => LoginBloc());
  locator.registerLazySingleton(() => Auth());
  locator.registerLazySingleton(() => TaskService());
}