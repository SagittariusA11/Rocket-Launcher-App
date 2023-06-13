
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Widget images(
      double? height,
      double? width,
      String? path,
      ) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(path!)
          )
      ),
    );
  }
}

class selectedAppLanguage {

  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future saveMode(String language) async =>
      await _preferences?.setString('language', language);

  static String? getMode() => _preferences?.getString('language');
  static bool isEn = selectedAppLanguage.getMode() == 'dark'?true:false;
  static bool isEs = selectedAppLanguage.getMode() == 'light'?true:false;
  static bool isHi = selectedAppLanguage.getMode() == 'red'?true:false;
  static bool isDe = selectedAppLanguage.getMode() == 'green'?true:false;
  static bool isMore = selectedAppLanguage.getMode() == 'blue'?true:false;
}