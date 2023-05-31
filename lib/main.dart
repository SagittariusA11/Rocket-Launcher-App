import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rocket_launcher_app/utils/routeNames.dart';
import 'package:rocket_launcher_app/utils/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black
    ));

    return const MaterialApp(
      title: 'Rocket Launcher Visualizer',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      initialRoute: RouteNames.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

