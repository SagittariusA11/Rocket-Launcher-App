import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme{

  //help_screen
  Color text = selectedAppTheme.isLightMode?
  Colors.white:selectedAppTheme.isDarkMode?
  Color.fromARGB(255, 211, 211, 211):selectedAppTheme.isRedMode?
  Color.fromARGB(255, 255, 216, 216):selectedAppTheme.isGreenMode?
  Color.fromARGB(255, 223, 255, 214):Color.fromARGB(255, 158, 181, 225);

  //menu background color
  Color menu_bg_color = selectedAppTheme.isLightMode? Color.fromARGB(204, 106, 161, 244):
  selectedAppTheme.isDarkMode? Color.fromARGB(255, 15, 28, 75):
  selectedAppTheme.isRedMode? Color.fromARGB(255, 128, 47, 47):
  selectedAppTheme.isGreenMode? Color.fromARGB(255, 52, 103, 39):
  Color.fromARGB(255, 30, 65, 138);

  //background color
  Color bg_color = selectedAppTheme.isLightMode? Color.fromARGB(255, 74, 147, 255):
  selectedAppTheme.isDarkMode? Color.fromARGB(255, 6, 15, 51):
  selectedAppTheme.isRedMode? Color.fromARGB(255, 98, 29, 29):
  selectedAppTheme.isGreenMode? Color.fromARGB(255, 30, 70, 17):
  Color.fromARGB(255, 12, 52, 126);

  //connect_button
  Color connect_color = selectedAppTheme.isLightMode? Colors.white:
  selectedAppTheme.isDarkMode? Color.fromARGB(255, 20, 52, 168):
  selectedAppTheme.isRedMode? Color.fromARGB(255, 185, 57, 57):
  selectedAppTheme.isGreenMode? Color.fromARGB(255, 72, 162, 42):
  Color.fromARGB(255, 25, 86, 206);

  static final darkTheme = ThemeData(

  );

  static final lightTheme = ThemeData(

  );

  static final redTheme = ThemeData(

  );

  static final greenTheme = ThemeData(

  );

  static final blueTheme = ThemeData(

  );

}

class selectedAppTheme {

  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future saveMode(String theme) async =>
      await _preferences?.setString('theme', theme);

  static String? getMode() => _preferences?.getString('theme');
  static bool isDarkMode = selectedAppTheme.getMode() == 'dark'?true:false;
  static bool isLightMode = selectedAppTheme.getMode() == 'light'?true:false;
  static bool isRedMode = selectedAppTheme.getMode() == 'red'?true:false;
  static bool isGreenMode = selectedAppTheme.getMode() == 'green'?true:false;
  static bool isBlueMode = selectedAppTheme.getMode() == 'blue'?true:false;

}