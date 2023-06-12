import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:rocket_launcher_app/views/translate.dart';

import '../config/imagePaths.dart';
import '../config/screenConfig.dart';
import '../utils/utils.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  bool _app_audio_and_music = false;
  bool _text_to_speech = false;
  bool _haptic = false;
  bool _voice_command = false;
  double _currentValue =  25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: ScreenConfig.width,
          height: ScreenConfig.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImagePaths.settings_bg),
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
                      const Text(
                        "Settings",
                        style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontSize: 30,
                            color: Colors.white,
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
                        // SizedBox(
                        //   height: ScreenConfig.heightPercent*2.5,
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Language",
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    changeLocale(context, "en");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: Color.fromARGB(255, 217, 217, 217),
                                    padding: EdgeInsets.all(15),
                                    shape: StadiumBorder(),
                                  ),
                                  child: SizedBox(
                                    width: ScreenConfig.widthPercent*10,
                                    height: ScreenConfig.widthPercent*7*0.25,
                                    child: const Center(
                                      child: Text(
                                          'English',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    changeLocale(context, "es");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: Color.fromARGB(255, 217, 217, 217),
                                    padding: EdgeInsets.all(15),
                                    shape: StadiumBorder(),
                                  ),
                                  child: SizedBox(
                                    width: ScreenConfig.widthPercent*10,
                                    height: ScreenConfig.widthPercent*7*0.25,
                                    child: const Center(
                                      child: Text(
                                          'Spanish',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    changeLocale(context, "hi");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: Color.fromARGB(255, 217, 217, 217),
                                    padding: EdgeInsets.all(15),
                                    shape: StadiumBorder(),
                                  ),
                                  child: SizedBox(
                                    width: ScreenConfig.widthPercent*10,
                                    height: ScreenConfig.widthPercent*7*0.25,
                                    child: const Center(
                                      child: Text(
                                          'Hindi',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () { },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: Color.fromARGB(255, 217, 217, 217),
                                    padding: EdgeInsets.all(15),
                                    shape: StadiumBorder(),
                                  ),
                                  child: SizedBox(
                                    width: ScreenConfig.widthPercent*10,
                                    height: ScreenConfig.widthPercent*7*0.25,
                                    child: const Center(
                                      child: Text(
                                          'German',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    onActionSheetPress(context, false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: Color.fromARGB(255, 217, 217, 217),
                                    padding: EdgeInsets.all(15),
                                    shape: StadiumBorder(),
                                  ),
                                  child: SizedBox(
                                    width: ScreenConfig.widthPercent*10,
                                    height: ScreenConfig.widthPercent*7*0.25,
                                    child: const Center(
                                      child: Text(
                                          'More',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
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
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Colour Theme",
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    primary: Color.fromARGB(255, 217, 217, 217),
                                    padding: EdgeInsets.all(15),
                                    shape: StadiumBorder(),
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
                                        child: const Center(
                                          child: Text(
                                              'Light',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      primary: Color.fromARGB(255, 217, 217, 217),
                                      padding: EdgeInsets.all(15),
                                      shape: StadiumBorder(),
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
                                          child: const Center(
                                            child: Text(
                                                'Dark',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold
                                                )),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      primary: Color.fromARGB(255, 217, 217, 217),
                                      padding: EdgeInsets.all(15),
                                      shape: StadiumBorder(),
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
                                          child: const Center(
                                            child: Text(
                                                'Red',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold
                                                )),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      primary: Color.fromARGB(255, 217, 217, 217),
                                      padding: EdgeInsets.all(15),
                                      shape: StadiumBorder(),
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
                                          child: const Center(
                                            child: Text(
                                                'Green',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold
                                                )),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      primary: Color.fromARGB(255, 217, 217, 217),
                                      padding: EdgeInsets.all(15),
                                      shape: StadiumBorder(),
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
                                          child: const Center(
                                            child: Text(
                                                'Blue',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
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
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Audio",
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
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
                                        const Text(
                                          "App audio and music",
                                          style: TextStyle(
                                              fontFamily: 'GoogleSans',
                                              fontSize: 25,
                                              color: Colors.white,
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
                                            activeColor: Colors.blue,
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
                                        const Text(
                                          "Text to Speech",
                                          style: TextStyle(
                                              fontFamily: 'GoogleSans',
                                              fontSize: 25,
                                              color: Colors.white,
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
                                            activeColor: Colors.blue,
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
                                        const Text(
                                          "Haptic response",
                                          style: TextStyle(
                                              fontFamily: 'GoogleSans',
                                              fontSize: 25,
                                              color: Colors.white,
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
                                            activeColor: Colors.blue,
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
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Font Size",
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
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
                                    color: Color.fromARGB(255, 83, 149, 248),
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
                                              _currentValue = value; // Update the current selected value
                                            });
                                          },
                                          activeColor: Colors.white,
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
                          height: 20,
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Voice Command",
                                style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Transform.scale(
                                scale: 1.25,
                                child: Switch(
                                  value: _voice_command,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _voice_command = value; // Update the switch state
                                    });
                                  },
                                  activeColor: Colors.blue,
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
