import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:rocket_launcher_app/views/translate.dart';

import '../config/imagePaths.dart';
import '../config/screenConfig.dart';
import '../utils/utils.dart';
import '../config/appTheme.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with SingleTickerProviderStateMixin {

  bool _app_audio_and_music = false;
  bool _text_to_speech = false;
  bool _haptic = false;
  bool _voice_command = false;
  double _currentValue = selectedFontSizeFactor.getMode()??25.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ScreenConfig.init(context);
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: ScreenConfig.width,
          height: ScreenConfig.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  selectedAppTheme.isLightMode? ImagePaths.settings_bg_light:
                  selectedAppTheme.isDarkMode? ImagePaths.settings_bg_dark:
                  selectedAppTheme.isRedMode? ImagePaths.settings_bg_red:
                  selectedAppTheme.isGreenMode? ImagePaths.settings_bg_green:
                  ImagePaths.settings_bg_blue,
                ),
                fit: BoxFit.cover
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Row(
                    children: [
                      Utils.images(
                          ScreenConfig.heightPercent*10,
                          ScreenConfig.heightPercent*10,
                          ImagePaths.rla_icon
                      ),
                      SizedBox(
                        width: ScreenConfig.widthPercent*2,
                      ),
                       Text(
                        translate('drawer.settings'),
                        style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontSize: Utils().fontSizeMultiplier(30),
                            color: AppTheme().text,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 10, 50, 10),
                  child: SizedBox(
                    width: ScreenConfig.widthPercent*80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translate('settings.language.language'),
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: Utils().fontSizeMultiplier(30),
                                  color: AppTheme().text,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedAppLanguage.isEn = true;
                                      selectedAppLanguage.isEs = false;
                                      selectedAppLanguage.isHi = false;
                                      selectedAppLanguage.isDe = false;
                                      selectedAppLanguage.isMore = false;
                                    });
                                    selectedAppLanguage.saveMode('en');
                                    changeLocale(context, "en");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: AppTheme().bg_color,
                                    padding: EdgeInsets.all(15),
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        color: selectedAppLanguage.isEn ? Colors.red : Colors.transparent,
                                        width: 5.0,
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: ScreenConfig.widthPercent*10,
                                    height: ScreenConfig.widthPercent*7*0.25,
                                    child: Center(
                                      child: Text(
                                          translate('language.name.en'),
                                          style: TextStyle(
                                              fontSize: Utils().fontSizeMultiplier(20),
                                              color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                              fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    changeLocale(context, "es");
                                    selectedAppLanguage.saveMode('es');
                                    setState(() {
                                      selectedAppLanguage.isEn = false;
                                      selectedAppLanguage.isEs = true;
                                      selectedAppLanguage.isHi = false;
                                      selectedAppLanguage.isDe = false;
                                      selectedAppLanguage.isMore = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: AppTheme().bg_color,
                                    padding: EdgeInsets.all(15),
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        color: selectedAppLanguage.isEs ? Colors.red : Colors.transparent,
                                        width: 5.0,
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: ScreenConfig.widthPercent*10,
                                    height: ScreenConfig.widthPercent*7*0.25,
                                    child: Center(
                                      child: Text(
                                          translate('language.name.es'),
                                          style: TextStyle(
                                              fontSize: Utils().fontSizeMultiplier(20),
                                              color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                              fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    changeLocale(context, "hi");
                                    selectedAppLanguage.saveMode('hi');
                                    setState(() {
                                      selectedAppLanguage.isEn = false;
                                      selectedAppLanguage.isEs = false;
                                      selectedAppLanguage.isHi = true;
                                      selectedAppLanguage.isDe = false;
                                      selectedAppLanguage.isMore = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: AppTheme().bg_color,
                                    padding: const EdgeInsets.all(15),
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        color: selectedAppLanguage.isHi ? Colors.red : Colors.transparent,
                                        width: 5.0,
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: ScreenConfig.widthPercent*10,
                                    height: ScreenConfig.widthPercent*7*0.25,
                                    child: Center(
                                      child: Text(
                                          translate('language.name.hi'),
                                          style: TextStyle(
                                              fontSize: Utils().fontSizeMultiplier(20),
                                              color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                              fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    selectedAppLanguage.saveMode('de');
                                    setState(() {
                                      selectedAppLanguage.isEn = false;
                                      selectedAppLanguage.isEs = false;
                                      selectedAppLanguage.isHi = false;
                                      selectedAppLanguage.isDe = true;
                                      selectedAppLanguage.isMore = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: AppTheme().bg_color,
                                    padding: const EdgeInsets.all(15),
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        color: selectedAppLanguage.isDe ? Colors.red : Colors.transparent,
                                        width: 5.0,
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: ScreenConfig.widthPercent*10,
                                    height: ScreenConfig.widthPercent*7*0.25,
                                    child: Center(
                                      child: Text(
                                          translate('language.name.de'),
                                          style: TextStyle(
                                              fontSize: Utils().fontSizeMultiplier(20),
                                              color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                              fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    selectedAppLanguage.saveMode('more');
                                    onActionSheetPress(context, false);
                                    setState(() {
                                      selectedAppLanguage.isEn = false;
                                      selectedAppLanguage.isEs = false;
                                      selectedAppLanguage.isHi = false;
                                      selectedAppLanguage.isDe = false;
                                      selectedAppLanguage.isMore = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: AppTheme().bg_color,
                                    padding: EdgeInsets.all(15),
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        color: selectedAppLanguage.isMore ? Colors.red : Colors.transparent,
                                        width: 5.0,
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: ScreenConfig.widthPercent*10,
                                    height: ScreenConfig.widthPercent*7*0.25,
                                    child: Center(
                                      child: Text(
                                          translate('settings.language.more'),
                                          style: TextStyle(
                                              fontSize: Utils().fontSizeMultiplier(20),
                                              color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                              fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translate('settings.theme.theme'),
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: Utils().fontSizeMultiplier(30),
                                  color: AppTheme().text,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedAppTheme.isDarkMode = false;
                                      selectedAppTheme.isLightMode = true;
                                      selectedAppTheme.isRedMode = false;
                                      selectedAppTheme.isGreenMode = false;
                                      selectedAppTheme.isBlueMode = false;
                                      selectedAppTheme.saveMode('light');
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: AppTheme().bg_color,
                                    padding: EdgeInsets.all(15),
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        color: selectedAppTheme.isLightMode ? Colors.red : Colors.transparent,
                                        width: 5.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: ScreenConfig.widthPercent*1,
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10), // Half the width/height value for a circular shape
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenConfig.widthPercent*7,
                                        height: ScreenConfig.widthPercent*7*0.25,
                                        child: Center(
                                          child: Text(
                                              translate('settings.theme.light'),
                                              style: TextStyle(
                                                  fontSize: Utils().fontSizeMultiplier(20),
                                                  color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                                  fontWeight: FontWeight.bold
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedAppTheme.isDarkMode = true;
                                        selectedAppTheme.isLightMode = false;
                                        selectedAppTheme.isRedMode = false;
                                        selectedAppTheme.isGreenMode = false;
                                        selectedAppTheme.isBlueMode = false;
                                        selectedAppTheme.saveMode('dark');
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      primary: AppTheme().bg_color,
                                      padding: EdgeInsets.all(15),
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: selectedAppTheme.isDarkMode ? Colors.red : Colors.transparent,
                                          width: 5.0,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: ScreenConfig.widthPercent*1,
                                        ),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(10), // Half the width/height value for a circular shape
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenConfig.widthPercent*7,
                                          height: ScreenConfig.widthPercent*7*0.25,
                                          child: Center(
                                            child: Text(
                                                translate('settings.theme.dark'),
                                                style: TextStyle(
                                                    fontSize: Utils().fontSizeMultiplier(20),
                                                    color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                                    fontWeight: FontWeight.bold
                                                )),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedAppTheme.isDarkMode = false;
                                        selectedAppTheme.isLightMode = false;
                                        selectedAppTheme.isRedMode = true;
                                        selectedAppTheme.isGreenMode = false;
                                        selectedAppTheme.isBlueMode = false;
                                        selectedAppTheme.saveMode('red');
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      primary: AppTheme().bg_color,
                                      padding: EdgeInsets.all(15),
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: selectedAppTheme.isRedMode ? Colors.red : Colors.transparent,
                                          width: 5.0,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: ScreenConfig.widthPercent*1,
                                        ),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(10), // Half the width/height value for a circular shape
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenConfig.widthPercent*7,
                                          height: ScreenConfig.widthPercent*7*0.25,
                                          child: Center(
                                            child: Text(
                                                translate('settings.theme.red'),
                                                style: TextStyle(
                                                    fontSize: Utils().fontSizeMultiplier(20),
                                                    color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                                    fontWeight: FontWeight.bold
                                                )),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedAppTheme.isDarkMode = false;
                                        selectedAppTheme.isLightMode = false;
                                        selectedAppTheme.isRedMode = false;
                                        selectedAppTheme.isGreenMode = true;
                                        selectedAppTheme.isBlueMode = false;
                                        selectedAppTheme.saveMode('green');
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      primary: AppTheme().bg_color,
                                      padding: EdgeInsets.all(15),
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: selectedAppTheme.isGreenMode ? Colors.red : Colors.transparent,
                                          width: 5.0,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: ScreenConfig.widthPercent*1,
                                        ),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(10), // Half the width/height value for a circular shape
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenConfig.widthPercent*7,
                                          height: ScreenConfig.widthPercent*7*0.25,
                                          child: Center(
                                            child: Text(
                                                translate('settings.theme.green'),
                                                style: TextStyle(
                                                    fontSize: Utils().fontSizeMultiplier(20),
                                                    color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                                    fontWeight: FontWeight.bold
                                                )),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedAppTheme.isDarkMode = false;
                                        selectedAppTheme.isLightMode = false;
                                        selectedAppTheme.isRedMode = false;
                                        selectedAppTheme.isGreenMode = false;
                                        selectedAppTheme.isBlueMode = true;
                                        selectedAppTheme.saveMode('blue');
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      primary: AppTheme().bg_color,
                                      padding: EdgeInsets.all(15),
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: selectedAppTheme.isBlueMode ? Colors.red : Colors.transparent,
                                          width: 5.0,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: ScreenConfig.widthPercent*1,
                                        ),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(10), // Half the width/height value for a circular shape
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenConfig.widthPercent*7,
                                          height: ScreenConfig.widthPercent*7*0.25,
                                          child: Center(
                                            child: Text(
                                                translate('settings.theme.blue'),
                                                style: TextStyle(
                                                    fontSize: Utils().fontSizeMultiplier(20),
                                                    color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                                    fontWeight: FontWeight.bold
                                                )),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translate('settings.audio.audio'),
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: Utils().fontSizeMultiplier(30),
                                  color: AppTheme().text,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: ScreenConfig.widthPercent*40,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: ScreenConfig.widthPercent*4,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          translate('settings.audio.aam'),
                                          style: TextStyle(
                                              fontFamily: 'GoogleSans',
                                              fontSize: Utils().fontSizeMultiplier(25),
                                              color: AppTheme().text,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Transform.scale(
                                          scale: 1.25,
                                          child: Switch(
                                            value: _app_audio_and_music,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _app_audio_and_music = value; // Update the switch state
                                              });
                                            },
                                            activeColor: Colors.white,
                                            inactiveThumbColor: Colors.grey,
                                            activeTrackColor: Colors.lightBlueAccent,
                                            inactiveTrackColor: Colors.grey.shade300,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          translate('settings.audio.tts'),
                                          style: TextStyle(
                                              fontFamily: 'GoogleSans',
                                              fontSize: Utils().fontSizeMultiplier(25),
                                              color: AppTheme().text,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Transform.scale(
                                          scale: 1.25,
                                          child: Switch(
                                            value: _text_to_speech,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _text_to_speech = value; // Update the switch state
                                              });
                                            },
                                            activeColor: Colors.white,
                                            inactiveThumbColor: Colors.grey,
                                            activeTrackColor: Colors.lightBlueAccent,
                                            inactiveTrackColor: Colors.grey.shade300,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          translate('settings.audio.hp'),
                                          style: TextStyle(
                                              fontFamily: 'GoogleSans',
                                              fontSize: Utils().fontSizeMultiplier(25),
                                              color: AppTheme().text,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Transform.scale(
                                          scale: 1.25,
                                          child: Switch(
                                            value: _haptic,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _haptic = value; // Update the switch state
                                              });
                                            },
                                            activeColor: Colors.white,
                                            inactiveThumbColor: Colors.grey,
                                            activeTrackColor: Colors.lightBlueAccent,
                                            inactiveTrackColor: Colors.grey.shade300,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translate('settings.fs'),
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: Utils().fontSizeMultiplier(30),
                                  color: AppTheme().text,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: ScreenConfig.widthPercent*40,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: ScreenConfig.widthPercent*4,
                                ),
                                child: Container(
                                  height: ScreenConfig.heightPercent*7,
                                  decoration: BoxDecoration(
                                    color: AppTheme().bg_color,
                                    borderRadius: BorderRadius.circular(ScreenConfig.heightPercent*7), // Half the width/height value for a circular shape
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      const Text(
                                        "A",
                                        style: TextStyle(
                                            fontFamily: 'GoogleSans',
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenConfig.widthPercent*25,
                                        child: Slider(
                                          value: _currentValue,
                                          min: 0,
                                          max: 100,
                                          divisions: 4, // Number of discrete values - 4 values with 3 intervals
                                          onChanged: (double value) {
                                            setState(() {
                                              _currentValue = value;
                                              selectedFontSizeFactor.saveMode(_currentValue);// Update the current selected value
                                            });
                                            if(_currentValue == 0.0) {
                                              selectedFontSizeFactor.zero = true;
                                              selectedFontSizeFactor.quarter = false;
                                              selectedFontSizeFactor.half = false;
                                              selectedFontSizeFactor.third = false;
                                              selectedFontSizeFactor.full = false;
                                            } else if(_currentValue == 25.0){
                                              selectedFontSizeFactor.zero = false;
                                              selectedFontSizeFactor.quarter = true;
                                              selectedFontSizeFactor.half = false;
                                              selectedFontSizeFactor.third = false;
                                              selectedFontSizeFactor.full = false;
                                            } else if(_currentValue == 50.0){
                                              selectedFontSizeFactor.zero = false;
                                              selectedFontSizeFactor.quarter = false;
                                              selectedFontSizeFactor.half = true;
                                              selectedFontSizeFactor.third = false;
                                              selectedFontSizeFactor.full = false;
                                            } else if(_currentValue == 75.0){
                                              selectedFontSizeFactor.zero = false;
                                              selectedFontSizeFactor.quarter = false;
                                              selectedFontSizeFactor.half = false;
                                              selectedFontSizeFactor.third = true;
                                              selectedFontSizeFactor.full = false;
                                            } else if(_currentValue == 100.0){
                                              selectedFontSizeFactor.zero = false;
                                              selectedFontSizeFactor.quarter = false;
                                              selectedFontSizeFactor.half = false;
                                              selectedFontSizeFactor.third = false;
                                              selectedFontSizeFactor.full = true;
                                            }
                                          },
                                          activeColor: Colors.white,
                                          inactiveColor: Colors.grey.shade300,
                                          label: _currentValue.round().toString(),
                                        ),
                                      ),
                                      const Text(
                                        "A",
                                        style: TextStyle(
                                            fontFamily: 'GoogleSans',
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                translate('settings.vc'),
                                style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    fontSize: Utils().fontSizeMultiplier(30),
                                    color: AppTheme().text,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Transform.scale(
                                scale: 1.35,
                                child: Switch(
                                  value: _voice_command,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _voice_command = value; // Update the switch state
                                    });
                                  },
                                  activeColor: Colors.white,
                                  inactiveThumbColor: Colors.grey,
                                  activeTrackColor: Colors.lightBlueAccent,
                                  inactiveTrackColor: Colors.grey.shade300,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenConfig.heightPercent*10,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
