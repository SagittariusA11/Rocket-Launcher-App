import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../animation/home_view_animation.dart';

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

  //bg_color
  Color bg_color = selectedAppTheme.isLightMode?Color.fromARGB(255, 180, 223, 255):
  selectedAppTheme.isDarkMode? Color.fromARGB(255, 0, 2, 17):
  selectedAppTheme.isRedMode? Color.fromARGB(255, 255, 182, 182):
  selectedAppTheme.isGreenMode? Color.fromARGB(255, 172, 255, 205):
  Color.fromARGB(255, 107, 162, 255);

  //cards_color
  Color cards_color = selectedAppTheme.isLightMode?Color.fromARGB(128, 136, 183, 246):
  selectedAppTheme.isDarkMode? Color.fromARGB(128, 69, 78, 164):
  selectedAppTheme.isRedMode? Color.fromARGB(255, 239, 45, 45):
  selectedAppTheme.isGreenMode? Color.fromARGB(255, 24, 155, 41):
  Color.fromARGB(255, 18, 69, 161);

  //tab_color
  Color tab_color = selectedAppTheme.isLightMode? Colors.blue.withOpacity(opacityAnimation.value):
  selectedAppTheme.isDarkMode? Color.fromARGB(255, 7, 20, 66).withOpacity(opacityAnimation.value):
  selectedAppTheme.isRedMode? Color.fromARGB(255, 189, 37, 37).withOpacity(opacityAnimation.value):
  selectedAppTheme.isGreenMode? Color.fromARGB(255, 52, 103, 39).withOpacity(opacityAnimation.value):
  Color.fromARGB(255, 23, 72, 173).withOpacity(opacityAnimation.value);

  //primary color
  Color primary_color = selectedAppTheme.isLightMode? Color.fromARGB(255, 29, 80, 154):
  selectedAppTheme.isDarkMode? Color.fromARGB(255, 0, 8, 28):
  selectedAppTheme.isRedMode? Color.fromARGB(255, 98, 29, 29):
  selectedAppTheme.isGreenMode? Color.fromARGB(255, 30, 70, 17):
  Color.fromARGB(255, 12, 52, 126);

  //elevated_button_color
  Color ebtn_color = selectedAppTheme.isLightMode? Color.fromARGB(255, 203, 221, 255):
  selectedAppTheme.isDarkMode? Color.fromARGB(255, 37, 51, 178):
  selectedAppTheme.isRedMode? Color.fromARGB(255, 255, 146, 146):
  selectedAppTheme.isGreenMode? Color.fromARGB(255, 127, 255, 123):
  Color.fromARGB(255, 86, 138, 255);

  //head_text_color
  Color ht_color = selectedAppTheme.isLightMode? Color.fromARGB(255, 29, 80, 154):
  selectedAppTheme.isDarkMode? Colors.white:
  selectedAppTheme.isRedMode? Color.fromARGB(255, 176, 0, 0):
  selectedAppTheme.isGreenMode? Color.fromARGB(255, 30, 70, 17):
  Color.fromARGB(255, 2, 37, 103);

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