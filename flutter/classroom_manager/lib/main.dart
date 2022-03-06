import 'package:classroom_manager/blocs/login_bloc/login_bloc.dart';
import 'package:classroom_manager/blocs/login_bloc/login_events.dart';
import 'package:classroom_manager/blocs/task_bloc/task_bloc.dart';
import 'package:classroom_manager/services/auth.dart';
import 'package:classroom_manager/services/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  await setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  runApp(const MyApp());
}

final LoginBloc loginBloc = locator.get<LoginBloc>();

initialization(BuildContext context) async {
  Auth _auth = locator<Auth>();
  bool login = await _auth.getLogin();
  if (login) {
    loginBloc.loginEventSink.add(HomeWidgetEvent());
  } else {
    loginBloc.loginEventSink.add(LoginWidgetEvent());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.white),
        primarySwatch: Colors.cyan,
      ),
      home: BlocProvider(
        create: (context) => TaskBloc(),
        child: StreamBuilder(
          initialData: loginBloc.widget,
          stream: loginBloc.widget_,
          builder: (context, snapshot) {
            return (snapshot.data as Widget);
          },
        ),
      ),
    );
  }
}
