import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:rocket_launcher_app/config/appTheme.dart';

import '../config/imagePaths.dart';
import '../config/screenConfig.dart';
import '../utils/utils.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().bg_color,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    translate('about.title'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(40),
                        fontWeight: FontWeight.bold,
                        color: AppTheme().ht_color
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0, top: 5),
              child: Text(
                translate('about.name'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: Utils().fontSizeMultiplier(50),
                    fontWeight: FontWeight.bold,
                    color: AppTheme().ht_color
                ),
              ),
            ),
            Utils.images(
                ScreenConfig.heightPercent*50,
                ScreenConfig.heightPercent*50,
                ImagePaths.rla_icon
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                translate('about.author'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Utils().fontSizeMultiplier(25),
                  color: AppTheme().ht_color,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                translate('about.mentor'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Utils().fontSizeMultiplier(25),
                  color: AppTheme().ht_color,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                translate('about.admin'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Utils().fontSizeMultiplier(25),
                  color: AppTheme().ht_color,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 50),
              child: Text(
                translate('about.contact'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Utils().fontSizeMultiplier(25),
                  color: AppTheme().ht_color,
                ),
              ),
            ),
            Utils.images(
                ScreenConfig.width*0.9*0.5625,
                ScreenConfig.width*0.9,
                ImagePaths.about_logo
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, top: 10, bottom: 5),
              child: Row(
                children: [
                  Text(
                    translate('about.all_about'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(27),
                      color: AppTheme().ht_color,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, top: 10),
              child: Row(
                children: [
                  Text(
                    translate('about.p1'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(20),
                      color: AppTheme().ht_color,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, top: 10),
              child: Row(
                children: [
                  Text(
                    translate('about.p2'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(20),
                      color: AppTheme().ht_color,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, top: 10),
              child: Row(
                children: [
                  Text(
                    translate('about.p3'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(20),
                      color: AppTheme().ht_color,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, top: 10),
              child: Row(
                children: [
                  Text(
                    translate('about.p4'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(20),
                      color: AppTheme().ht_color,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, top: 10),
              child: Row(
                children: [
                  Text(
                    translate('about.p5'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(20),
                      color: AppTheme().ht_color,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, top: 10),
              child: Row(
                children: [
                  Text(
                    translate('about.p6'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(20),
                      color: AppTheme().ht_color,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, top: 10, bottom: 100),
              child: Row(
                children: [
                  Text(
                    translate('about.p7'),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(20),
                      color: AppTheme().ht_color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
