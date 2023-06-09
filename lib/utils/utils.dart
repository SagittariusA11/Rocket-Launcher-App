
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/imagePaths.dart';
import '../config/screenConfig.dart';
import '../config/appTheme.dart';

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

  double fontSizeMultiplier(double fontSize){
    if(selectedFontSizeFactor.zero){
      return fontSize*0.90;
    } else if(selectedFontSizeFactor.quarter){
      return fontSize;
    } else if(selectedFontSizeFactor.half){
      return fontSize*1.08;
    } else if(selectedFontSizeFactor.third){
      return fontSize*1.16;
    } else if(selectedFontSizeFactor.full){
      return fontSize*1.25;
    } else {
      return fontSize;
    }
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

}

class selectedAppLanguage {

  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future saveMode(String language) async =>
      await _preferences?.setString('language', language);

  static String? getMode() => _preferences?.getString('language');

  static bool isEn = selectedAppLanguage.getMode() == 'en'?true:false;
  static bool isEs = selectedAppLanguage.getMode() == 'es'?true:false;
  static bool isHi = selectedAppLanguage.getMode() == 'hi'?true:false;
  static bool isDe = selectedAppLanguage.getMode() == 'de'?true:false;
  static bool isMore = selectedAppLanguage.getMode() == 'more'?true:false;
}

class selectedFontSizeFactor {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future saveMode(double fontSizeFactor) async =>
      await _preferences?.setDouble('fontSizeFactor', fontSizeFactor);
  static double? getMode() => _preferences?.getDouble('fontSizeFactor');

  static bool zero = selectedFontSizeFactor.getMode() == 0.0?true:false;
  static bool quarter = selectedFontSizeFactor.getMode() == 25.0?true:false;
  static bool half = selectedFontSizeFactor.getMode() == 50.0?true:false;
  static bool third = selectedFontSizeFactor.getMode() == 75.0?true:false;
  static bool full = selectedFontSizeFactor.getMode() == 100.0?true:false;
}

class ImageGrid extends StatelessWidget {
  const ImageGrid({Key? key, required this.imgs}) : super(key: key);
  final List imgs;

  @override
  Widget build(BuildContext context) {
    if(imgs.length != 0){
      return GridView.builder(
        itemCount: imgs.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imgs[index]),
                fit: BoxFit.cover,
              ),
            ),
            // child: Image.network("https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg", fit: BoxFit.contain)
          );
        },
      );
    } else {
      return Center(child: Text("Nothiung to show"));
    }
  }
}