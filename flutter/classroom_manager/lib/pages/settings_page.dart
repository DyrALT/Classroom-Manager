import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../blocs/student_bloc/student_bloc.dart';
import '../blocs/task_bloc/task_bloc.dart';
import '../services/auth.dart';
import '../services/locator.dart';
import 'login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Auth _auth = locator<Auth>();

  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
            onPressed: () async {
              _auth.logout();

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Cikis Yap'))
      ],
    );
  }
}
