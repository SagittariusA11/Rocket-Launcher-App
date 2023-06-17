
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/appTheme.dart';
import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../utils/utils.dart';

class PayloadInfo{

  static Widget satelliteInfo(
      BuildContext context,
      ){
    return Center(
      child: Container(
        height: ScreenConfig.heightPercent*58,
        width: ScreenConfig.widthPercent*50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey.shade300.withOpacity(0.85),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: ScreenConfig.widthPercent*50,
                height: ScreenConfig.heightPercent*48,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  color: AppTheme().menu_bg_color,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          translate('satellite_info.sn'),
                          style: TextStyle(
                              fontSize: Utils().fontSizeMultiplier(35),
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${translate('satellite_info.d')}:    22-06-2022",
                      style: TextStyle(
                          fontSize: Utils().fontSizeMultiplier(22),
                          color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${translate('satellite_info.rn')}:    Falcon 9",
                      style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(22),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${translate('satellite_info.ls')}:    Cape Canaveral Space Launch Complex",
                      style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(22),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${translate('satellite_info.m')}:    800 Kg",
                      style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(22),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${translate('satellite_info.o')}:    Low Earth",
                      style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(22),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${translate('satellite_info.n')}:    United States",
                      style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(22),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${translate('satellite_info.c')}:    SpaceX",
                      style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(22),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
                              height: ScreenConfig.heightPercent*4,
                              child: Center(
                                child: Text(
                                    translate('launch_tab.vlg'),
                                    style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(20),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget starlinkAPIInfoTable(
      String text,
      double fontSize,
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
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget starlinkInfo(
      BuildContext context,
      ){
    return Center(
      child: Container(
        height: ScreenConfig.heightPercent*58,
        width: ScreenConfig.widthPercent*50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey.shade300.withOpacity(0.85),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: ScreenConfig.widthPercent*50,
                height: ScreenConfig.heightPercent*48,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  color: AppTheme().menu_bg_color,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          translate('starlink_info.sn'),
                          style: TextStyle(
                              fontSize: Utils().fontSizeMultiplier(35),
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${translate('starlink_info.d')}:    22-06-2022",
                      style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(22),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${translate('starlink_info.rn')}:    Falcon 9",
                      style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(22),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${translate('starlink_info.ls')}:    Cape Canaveral Space Launch Complex",
                      style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(22),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${translate('starlink_info.n')}:    United States",
                      style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(22),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            starlinkAPIInfoTable(translate('starlink_info.long'), 22),
                            starlinkAPIInfoTable("165.9304", 20),
                          ],
                        ),
                        Column(
                          children: [
                            starlinkAPIInfoTable(translate('starlink_info.lat'), 22),
                            starlinkAPIInfoTable("-52.9131", 20),
                          ],
                        ),
                        Column(
                          children: [
                            starlinkAPIInfoTable(translate('starlink_info.h'), 22),
                            starlinkAPIInfoTable("446.61 Km", 20),
                          ],
                        ),
                        Column(
                          children: [
                            starlinkAPIInfoTable(translate('starlink_info.v'), 22),
                            starlinkAPIInfoTable("7.64 Km/s", 20),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
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
                              height: ScreenConfig.heightPercent*4,
                              child: Center(
                                child: Text(
                                    translate('launch_tab.vlg'),
                                    style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(20),
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