import 'package:flutter/material.dart';

class ScreenConfig {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late double widthPercent;
  static late double heightPercent;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    //Screen Size
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;

    widthPercent = width * 0.01;
    heightPercent = height * 0.01;
  }
}