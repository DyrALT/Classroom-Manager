import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? date;
  final void Function()? onTap;
  const ListItem({Key? key, required this.title, this.subtitle, this.date, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(title), subtitle: Text(subtitle ?? '', overflow: TextOverflow.ellipsis), trailing: Text(date ?? ''), onTap: onTap);
  }
}
