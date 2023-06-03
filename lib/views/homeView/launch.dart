import 'package:flutter/material.dart';

class LaunchView extends StatefulWidget {
  const LaunchView({Key? key}) : super(key: key);

  @override
  State<LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("This is Launch"),
    );
  }
}
