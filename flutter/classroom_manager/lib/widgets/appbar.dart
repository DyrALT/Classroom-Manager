import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final List<Widget>? widgets;

  /// example:
  ///
  ///` appBar: MyAppBar(title: 'Classroom Manager', appBar: AppBar(), widgets: const []),`
  const MyAppBar({Key? key, required this.title, required this.appBar, required this.widgets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.white, //change your color here
      ),
      centerTitle: true,
      actions: widgets,
      title: Text(
        title,
        style: const TextStyle(
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
