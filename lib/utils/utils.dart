
import 'package:flutter/cupertino.dart';

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