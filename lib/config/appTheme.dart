import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme{

  //help_screen
  Color hh1 = selectedAppTheme.isLightMode?
  Colors.white:selectedAppTheme.isDarkMode?
  Color.fromARGB(255, 201, 201, 201):selectedAppTheme.isRedMode?
  Color.fromARGB(255, 225, 167, 167):selectedAppTheme.isGreenMode?
  Color.fromARGB(255, 181, 227, 167):Color.fromARGB(255, 136, 165, 218);

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