import 'package:flutter/material.dart';

import '../config/imagePaths.dart';
import '../config/screenConfig.dart';
import '../utils/utils.dart';

class HelpView extends StatefulWidget {
  const HelpView({Key? key}) : super(key: key);

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenConfig.width,
        height: ScreenConfig.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImagePaths.help_bg),
                fit: BoxFit.cover
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, bottom: 20),
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
                      "Help",
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
                padding: EdgeInsets.only(
                    left: ScreenConfig.widthPercent*3,
                    bottom: 20
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Instructions for Setting up the Visualization:",
                          style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*85,
                          child: const FittedBox(
                            child: Text(
                              "1. First, go to Connection Manager, which can be found in the menu, and fill in the credentials. The examples are mentioned there as placeholders.\n"
                                  "2. Then go to the Launch List Tab and tap on the Mission you want to visualize. Wait for the 'Ready to visualize' Toast message to appear, then \n    hit the 'Visualize in LG' button. You will be able to see the desired visualization in the Liquid Galaxy Rig.\n"
                                  "3. You can navigate through the LG from the Map tab, learn what the icons and colored polygons stand for from the 'Info Tab', and Clean the \n    visualization with the help of 'LG Tasks' from the menu.",
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenConfig.widthPercent*3,
                    bottom: 20
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Troubleshooting:",
                          style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*80,
                          child: const FittedBox(
                            child: Text(
                              "1. If you can not connect to the LG rig, first make sure they are both on the same network; either you can connect to \n   the WiFi of a third device or connect LG to the Tablet's hotspot. Check that the credentials are correctly filled in and try again.\n"
                                  "2. To find the IP address of the LG (or the host Laptop in case of VM setup), type 'ifconfig' in the terminal if \n  you're on Mac or Linux and 'ipconfig' for Windows.\n"
                                  "3. For low-end LG rigs, sometimes the visualization doesn't appear the first time. Hit the 'Visualize in LG' button \n   once more to solve this.",
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenConfig.widthPercent*3
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Map Controls:",
                          style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*65,
                          child: const FittedBox(
                            child: Text(
                              "1. To Navigate in the LG rig, one can use the interface of the Map screen.\n"
                                  "2. To Drag, we can use one finger movement in any direction in the Map screen.\n"
                                  "3. To Twist at an angle, one can use two fingers and give a screw movement in the Map screen.\n"
                                  "4. To Zoom, one can pinch the screen and move the fingers outwards or inwards to zoom in and zoom \n     out, respectively. We can also zoom by pressing the + and - icons provided on the Map screen.\n"
                                  "5. To Tilt, one can use two fingers and give it linear movement in an upward direction.",
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
