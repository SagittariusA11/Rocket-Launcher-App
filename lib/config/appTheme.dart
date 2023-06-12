import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme{

  /// TODO: Colour Pallet to be added for different themes

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