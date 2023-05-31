import 'package:flutter/material.dart';

class LaunchMap extends StatefulWidget {
  const LaunchMap({Key? key}) : super(key: key);

  @override
  State<LaunchMap> createState() => _LaunchMapState();
}

class _LaunchMapState extends State<LaunchMap> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Launch Map"),
    );
  }
}
