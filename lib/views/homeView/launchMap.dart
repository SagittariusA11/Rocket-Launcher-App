import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../utils/utils.dart';
import '../../config/appTheme.dart';

class LaunchMap extends StatefulWidget {
  const LaunchMap({Key? key}) : super(key: key);

  @override
  State<LaunchMap> createState() => _LaunchMapState();
}

class _LaunchMapState extends State<LaunchMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: ScreenConfig.width,
          height: ScreenConfig.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    selectedAppTheme.isLightMode? ImagePaths.launchMap_bg_light:
                    selectedAppTheme.isDarkMode? ImagePaths.launchMap_bg_dark:
                    selectedAppTheme.isRedMode? ImagePaths.launchMap_bg_red:
                    selectedAppTheme.isGreenMode? ImagePaths.launchMap_bg_green:
                    ImagePaths.launchMap_bg_blue,
                  ),
                  fit: BoxFit.cover
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: ScreenConfig.widthPercent*35,
                  child: Row(
                    children: [
                      SizedBox(
                        width: ScreenConfig.widthPercent*1.75,
                      ),
                      Utils.images(
                          ScreenConfig.heightPercent*10,
                          ScreenConfig.heightPercent*10,
                          ImagePaths.rla_icon
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translate('connection.label_l1'),
                            style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontSize: Utils().fontSizeMultiplier(30),
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            translate('connection.label_l2'),
                            style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontSize: Utils().fontSizeMultiplier(20),
                                color: Colors.white
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
