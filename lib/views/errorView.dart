import 'package:flutter/material.dart';

class ErrorView extends StatefulWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Error View"),
    );
  }
}
