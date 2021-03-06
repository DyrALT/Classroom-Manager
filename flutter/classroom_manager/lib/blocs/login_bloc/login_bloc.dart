import 'dart:async';

import "package:flutter/material.dart";

import '../../pages/home_page.dart';
import '../../pages/login_page.dart';
import 'login_events.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc {
  Widget widget = const Login();
  final _loginStateStreamController = StreamController.broadcast();
  Stream get widget_ => _loginStateStreamController.stream;
  StreamSink get _loginStateSink => _loginStateStreamController.sink;

  final _loginEventStreamController = StreamController<LoginEvent>();
  Stream<LoginEvent> get _loginEventStream => _loginEventStreamController.stream;
  StreamSink<LoginEvent> get loginEventSink => _loginEventStreamController.sink;
  LoginBloc() {
    _loginEventStream.listen(_mapEventToState);
  }

  void _mapEventToState(LoginEvent event) async {
    if (event is HomeWidgetEvent) {
      widget = const Home();
    }
    if (event is LoginWidgetEvent) {
      widget = const Login();
    }
    _loginStateSink.add(widget);
  }
}
