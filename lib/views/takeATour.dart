import 'package:flutter/material.dart';

class TakeATourView extends StatefulWidget {
  const TakeATourView({Key? key}) : super(key: key);

  @override
  State<TakeATourView> createState() => _TakeATourViewState();
}

class _TakeATourViewState extends State<TakeATourView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Take A Tour"),
    );
  }
}
