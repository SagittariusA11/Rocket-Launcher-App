import 'package:flutter/material.dart';

class RocketInfo extends StatefulWidget {
  const RocketInfo({Key? key}) : super(key: key);

  @override
  State<RocketInfo> createState() => _RocketInfoState();
}

class _RocketInfoState extends State<RocketInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Rocket Info"),
    );
  }
}
