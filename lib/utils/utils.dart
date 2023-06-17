
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Widget rocketInfo(){
    return Center(
      child: Scaffold(
          body: Container(
            width: ScreenConfig.width,
            height: ScreenConfig.heightPercent*65,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      selectedAppTheme.isLightMode? ImagePaths.launchInfo_bg_light:
                      selectedAppTheme.isDarkMode? ImagePaths.launchInfo_bg_dark:
                      selectedAppTheme.isRedMode? ImagePaths.launchInfo_bg_red:
                      selectedAppTheme.isGreenMode? ImagePaths.launchInfo_bg_green:
                      ImagePaths.launchInfo_bg_blue,
                    ),
                    fit: BoxFit.cover
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  height: ScreenConfig.heightPercent*58,
                  width: ScreenConfig.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppTheme().bg_color.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: ScreenConfig.heightPercent*56,
                        width: ScreenConfig.widthPercent*18,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              translate('launchInfo_tab.mn'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: Utils().fontSizeMultiplier(30),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Container(
                              height: ScreenConfig.heightPercent*41,
                              width: ScreenConfig.heightPercent*41*0.385,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(ImagePaths.rocket),
                                    fit: BoxFit.fill
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () { },
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  shadowColor: Colors.grey,
                                  primary: AppTheme().bg_color,
                                  shape: const StadiumBorder(),
                                ),
                                child: SizedBox(
                                  width: ScreenConfig.widthPercent*9,
                                  height: ScreenConfig.heightPercent*3,
                                  child: Center(
                                    child: Text(
                                        translate('launchInfo_tab.mi'),
                                        style: TextStyle(
                                          fontSize: Utils().fontSizeMultiplier(20),
                                          color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                        )
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: ScreenConfig.heightPercent*56,
                          width: ScreenConfig.widthPercent*30,
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 5.0, color: Colors.white),
                              right: BorderSide(width: 5.0, color: Colors.white),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${translate('launchInfo_tab.rn')}:   ${translate('launchInfo_tab.rn_01')}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${translate('launchInfo_tab.date')}:   2018-07-22",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${translate('launchInfo_tab.time')}:   05:50:00 UTC",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${translate('launchInfo_tab.ls')}:   ${translate('launchInfo_tab.ls_01')}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${translate('launchInfo_tab.fn')}:   65",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${translate('launchInfo_tab.py')}:   ${translate('launchInfo_tab.py_01')}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${translate('launchInfo_tab.n')}:    ${translate('launchInfo_tab.n_01')}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${translate('launchInfo_tab.ct')}:    ${translate('launchInfo_tab.ct_01')}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${translate('launchInfo_tab.orb')}:    ${translate('launchInfo_tab.orb_01')}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () { },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        shadowColor: Colors.grey,
                                        primary: AppTheme().bg_color,
                                        shape: const StadiumBorder(),
                                      ),
                                      child: SizedBox(
                                        width: ScreenConfig.widthPercent*3.75,
                                        height: ScreenConfig.heightPercent*3,
                                        child: Center(
                                          child: Text(
                                              translate('launchInfo_tab.art'),
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                              )
                                          ),
                                        ),
                                      )
                                  ),
                                  ElevatedButton(
                                      onPressed: () { },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        shadowColor: Colors.grey,
                                        primary: AppTheme().bg_color,
                                        shape: const StadiumBorder(),
                                      ),
                                      child: SizedBox(
                                        width: ScreenConfig.widthPercent*2.5,
                                        height: ScreenConfig.heightPercent*3,
                                        child: Center(
                                          child: Text(
                                              translate('launchInfo_tab.wiki'),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                              )
                                          ),
                                        ),
                                      )
                                  ),
                                  ElevatedButton(
                                      onPressed: () { },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        shadowColor: Colors.grey,
                                        primary: AppTheme().bg_color,
                                        shape: const StadiumBorder(),
                                      ),
                                      child: SizedBox(
                                        width: ScreenConfig.widthPercent*4.25,
                                        height: ScreenConfig.heightPercent*3,
                                        child: Center(
                                          child: Text(
                                              translate('launchInfo_tab.img'),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                              )
                                          ),
                                        ),
                                      )
                                  ),
                                  ElevatedButton(
                                      onPressed: () { },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        shadowColor: Colors.grey,
                                        primary: AppTheme().bg_color,
                                        shape: const StadiumBorder(),
                                      ),
                                      child: SizedBox(
                                        width: ScreenConfig.widthPercent*5,
                                        height: ScreenConfig.heightPercent*3,
                                        child: Center(
                                          child: Text(
                                              translate('launchInfo_tab.tl'),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                              )
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              )
                            ],
                          )
                      ),
                      SizedBox(
                        height: ScreenConfig.heightPercent*56,
                        width: ScreenConfig.widthPercent*44,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              height: ScreenConfig.heightPercent*20,
                              width: ScreenConfig.widthPercent*44,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 3.0, color: Colors.white),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${translate('launchInfo_tab.md')}:",
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    translate('launchInfo_tab.md_01'),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              height: ScreenConfig.heightPercent*36,
                              width: ScreenConfig.widthPercent*44,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${translate('launchInfo_tab.lsd')}:",
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    translate('launchInfo_tab.lsfn'),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    translate('launchInfo_tab.lsd_01'),
                                    style: const TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () { },
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shadowColor: Colors.grey,
                          primary: AppTheme().bg_color,
                          padding: EdgeInsets.all(10),
                          shape: StadiumBorder(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: ScreenConfig.widthPercent*2,
                            ),
                            SizedBox(
                              width: ScreenConfig.widthPercent*13,
                              height: ScreenConfig.heightPercent*5,
                              child: Center(
                                child: Text(
                                    translate('launchInfo_tab.ytv'),
                                    style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(23),
                                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                    )),
                              ),
                            ),
                            const Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                              size: 35,
                            ),
                            SizedBox(
                              width: ScreenConfig.widthPercent*2,
                            ),
                          ],
                        )
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () { },
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shadowColor: Colors.grey,
                          primary: AppTheme().bg_color,
                          padding: EdgeInsets.all(10),
                          shape: StadiumBorder(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: ScreenConfig.widthPercent*2,
                            ),
                            SizedBox(
                              width: ScreenConfig.widthPercent*27,
                              height: ScreenConfig.heightPercent*5,
                              child: Center(
                                child: Text(
                                    translate('launch_tab.vlg'),
                                    style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(23),
                                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                    )),
                              ),
                            ),
                            const Icon(
                              Icons.location_pin,
                              color: Colors.black,
                              size: 35,
                            ),
                            SizedBox(
                              width: ScreenConfig.widthPercent*2,
                            ),
                          ],
                        )
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () { },
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shadowColor: Colors.grey,
                          primary: AppTheme().bg_color,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          shape: const StadiumBorder(),
                        ),
                        child: SizedBox(
                          width: ScreenConfig.widthPercent*6,
                          height: ScreenConfig.heightPercent*5,
                          child: Center(
                            child: Text(
                                translate('launch_tab.dlg'),
                                style: TextStyle(
                                    fontSize: Utils().fontSizeMultiplier(20),
                                    color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ),
                        )
                    ),
                  ],
                )
              ],
            ),
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