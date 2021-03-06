import 'package:classroom_manager/pages/create_student_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../widgets/appbar.dart';
import 'create_task_page.dart';
import 'settings_page.dart';
import 'students_view_page.dart';
import 'tasks_view_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  final _tabPages = [const TaskListView(), const StudentsListView(), const SettingsPage()];
  final _tabs = [
    const Tab(icon: Icon(Icons.content_paste_sharp)),
    const Tab(icon: Icon(Icons.group)),
    const Tab(icon: Icon(Icons.settings)),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabPages.length,
      initialIndex: 0,
      vsync: this,
    );
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: MyAppBar(title: 'Classroom Manager', appBar: AppBar(), widgets: const []),
      body: TabBarView(
        children: _tabPages,
        controller: _tabController,
      ),
      floatingActionButton: floatButtons(),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 7,
        child: TabBar(
          tabs: _tabs,
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
        ),
      ),
    );
  }

  Widget? floatButtons() {
    return _tabController.index == 0
        ? FloatingActionButton(
            shape: const StadiumBorder(),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CreateTaskPage(),
              ));
            },
            foregroundColor: Colors.white,
            child: const Icon(
              Icons.add,
            ))
        : _tabController.index == 1
            ? FloatingActionButton(
                shape: const StadiumBorder(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateStudentPage(),
                  ));
                },
                foregroundColor: Colors.white,
                child: const Icon(
                  Icons.group_add,
                ),
              )
            : null;
  }
}
