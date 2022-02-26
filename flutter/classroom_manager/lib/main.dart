import 'package:classroom_manager/bloc/login_bloc/login_bloc.dart';
import 'package:classroom_manager/bloc/login_bloc/login_events.dart';
import 'package:classroom_manager/services/Auth.dart';
import 'package:classroom_manager/services/Locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  await setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  runApp(MyApp());
}

final LoginBloc loginBloc = locator.get<LoginBloc>();

initialization(BuildContext context) async {
  Auth _auth = Auth();
  var login = await _auth.getLogin();
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
        appBarTheme: AppBarTheme(color: Colors.white),
        primarySwatch: Colors.cyan,
      ),
      home: StreamBuilder(
        initialData: loginBloc.widget,
        stream: loginBloc.widget_,
        builder: (context, snapshot) {
          return (snapshot.data as Widget);
        },
      ),
    );
  }
}
