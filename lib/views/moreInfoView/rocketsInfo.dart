
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rocket_launcher_app/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/appTheme.dart';
import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../utils/routeNames.dart';
import '../../utils/utils.dart';

class RocketsInfo{

  static Widget rocketAPIInfoTable(
      String text,
      double fontSize,
      TextAlign alignment
      ){
    return Container(
      height: ScreenConfig.heightPercent*5,
      width: ScreenConfig.widthPercent*11,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(width: 1.0, color: Colors.white),
          right: BorderSide(width: 1.0, color: Colors.white),
          top: BorderSide(width: 1.0, color: Colors.white),
          bottom: BorderSide(width:  1.0, color: Colors.white),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
        textAlign: alignment,
      ),
    );
  }

  static Widget rocketInfo(
      BuildContext context,
      ){
    return Material(
      child: Center(
        child: Container(
          height: ScreenConfig.height,
          width: ScreenConfig.width,
          color: Colors.grey.shade300.withOpacity(0.75),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: AppTheme().bg_color,
                          size: 50,
                        )
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenConfig.widthPercent*95,
                height: ScreenConfig.heightPercent*80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppTheme().menu_bg_color,
                ),
                child: SizedBox(
                  height: ScreenConfig.heightPercent*58,
                  width: ScreenConfig.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        height: ScreenConfig.heightPercent*80,
                        width: ScreenConfig.heightPercent*80*0.325,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImagePaths.rocket),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 50),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: ScreenConfig.heightPercent*80,
                          width: ScreenConfig.widthPercent*69,
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 5.0, color: Colors.white),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: const [
                                        FaIcon(
                                          FontAwesomeIcons.images,
                                          color: Colors.transparent,
                                          size: 35,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        FaIcon(
                                          FontAwesomeIcons.globe,
                                          color: Colors.transparent,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      translate('rocket_info.rn'),
                                      style: TextStyle(
                                          fontSize: Utils().fontSizeMultiplier(35),
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(RouteNames.imageView);
                                            },
                                            icon: const FaIcon(
                                              FontAwesomeIcons.images,
                                              color: Colors.white,
                                              size: 35,
                                            )
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              launchUrl(Uri.parse('https://en.wikipedia.org/wiki/Falcon_9'));
                                              // print("Hello");
                                            },
                                            icon: const FaIcon(
                                              FontAwesomeIcons.globe,
                                              color: Colors.white,
                                              size: 30,
                                            )
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    translate('rocket_info.des'),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${translate('rocket_info.ff')}:   2010-06-04",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${translate('rocket_info.h')}:   70 m",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${translate('rocket_info.w')}:   549054 kg",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${translate('rocket_info.d')}:   3.7 m",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${translate('rocket_info.ll')}:   4",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${translate('rocket_info.p_1')}:   Liquid oxygen",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${translate('rocket_info.p_2')}:   RP-1 Kerosene",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${translate('rocket_info.tw')}:   180.1",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: ScreenConfig.widthPercent*66.32,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(width: 2.0, color: Colors.white),
                                        right: BorderSide(width: 2.0, color: Colors.white),
                                        top: BorderSide(width: 2.0, color: Colors.white),
                                        bottom: BorderSide(width:  2.0, color: Colors.white),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            rocketAPIInfoTable(
                                                "",
                                                22,
                                                TextAlign.start
                                            ),
                                            rocketAPIInfoTable(
                                                "${translate('rocket_info.fs')}:",
                                                22,
                                                TextAlign.start),
                                            rocketAPIInfoTable(
                                                "${translate('rocket_info.ss')}:",
                                                22,
                                                TextAlign.start
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            rocketAPIInfoTable(
                                                translate('rocket_info.r'),
                                                22,
                                                TextAlign.center
                                            ),
                                            rocketAPIInfoTable(
                                                "Yes",
                                                20,
                                                TextAlign.center
                                            ),
                                            rocketAPIInfoTable(
                                                "No",
                                                20,
                                                TextAlign.center
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            rocketAPIInfoTable(
                                                translate('rocket_info.e'),
                                                22,
                                                TextAlign.center
                                            ),
                                            rocketAPIInfoTable(
                                                "9",
                                                20,
                                                TextAlign.center
                                            ),
                                            rocketAPIInfoTable(
                                                "1",
                                                20,
                                                TextAlign.center
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            rocketAPIInfoTable(
                                                translate('rocket_info.t'),
                                                22,
                                                TextAlign.center
                                            ),
                                            rocketAPIInfoTable(
                                                "7670 kN",
                                                20,
                                                TextAlign.center
                                            ),
                                            rocketAPIInfoTable(
                                                "934 kN",
                                                22,
                                                TextAlign.center
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            rocketAPIInfoTable(
                                                translate('rocket_info.f'),
                                                22,
                                                TextAlign.center
                                            ),
                                            rocketAPIInfoTable(
                                                "385 Tons",
                                                20,
                                                TextAlign.center
                                            ),
                                            rocketAPIInfoTable(
                                                "90 Tons",
                                                20,
                                                TextAlign.center
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            rocketAPIInfoTable(
                                                translate('rocket_info.bt'),
                                                22,
                                                TextAlign.center
                                            ),
                                            rocketAPIInfoTable(
                                                "162 s",
                                                20,
                                                TextAlign.center
                                            ),
                                            rocketAPIInfoTable(
                                                "397 s",
                                                20,
                                                TextAlign.center
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageGrid extends StatefulWidget {
  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: NetworkImage("https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          // child: Image.network("https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg", fit: BoxFit.contain)
        );
      },
    );
  }
}
