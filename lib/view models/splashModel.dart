import 'package:flutter/material.dart';

import '../utils/routeNames.dart';

class SplashModel{

  initiateApp(BuildContext context)async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).popAndPushNamed(RouteNames.connectionManager);
  }

}