import 'package:get_it/get_it.dart';

import '../bloc/login_bloc/login_bloc.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator()async {
  locator.registerLazySingleton(() => LoginBloc());
}