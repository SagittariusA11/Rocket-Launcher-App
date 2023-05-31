import 'package:flutter/material.dart';

class LaunchList extends StatefulWidget {
  const LaunchList({Key? key}) : super(key: key);

  @override
  State<LaunchList> createState() => _LaunchListState();
}

class _LaunchListState extends State<LaunchList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Launch List"),
    );
  }
}
