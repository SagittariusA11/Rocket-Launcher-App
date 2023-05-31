import 'package:flutter/material.dart';

class YTLive extends StatefulWidget {
  const YTLive({Key? key}) : super(key: key);

  @override
  State<YTLive> createState() => _YTLiveState();
}

class _YTLiveState extends State<YTLive> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("YT Live"),
    );
  }
}
