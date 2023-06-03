import 'package:flutter/material.dart';

class LaunchInfo extends StatefulWidget {
  const LaunchInfo({Key? key}) : super(key: key);

  @override
  State<LaunchInfo> createState() => _LaunchInfoState();
}

class _LaunchInfoState extends State<LaunchInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Launch Info"),
    );
  }
}
