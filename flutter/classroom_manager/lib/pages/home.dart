import 'package:classroom_manager/pages/addStudentPage.dart';
import 'package:classroom_manager/pages/addTaskPage.dart';
import 'package:classroom_manager/widgets/StudentsWidget.dart';
import 'package:classroom_manager/widgets/TasksWidget.dart';
import 'package:classroom_manager/widgets/SettingsWidget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  final _tabPages = [
    const TasksWidget(),
    const StudentsWidget(),
    const SettingsWidget()
  ];
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Classrom Manager',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.cyan.shade800,
            Colors.cyan.shade500,
            Colors.cyan.shade400,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        ),
      ),
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
            shape: StadiumBorder(),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddTaskPage(),
              ));
            },
            foregroundColor: Colors.white,
            child: const Icon(
              Icons.add,
            ))
        : _tabController.index == 1
            ? FloatingActionButton(
                shape: StadiumBorder(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddStudentPage(),
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
