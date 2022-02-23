import 'package:classroom_manager/bloc/login_bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator()async {
  locator.registerLazySingleton(() => LoginBloc());
}