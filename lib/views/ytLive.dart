import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/appTheme.dart';
import '../config/imagePaths.dart';
import '../config/screenConfig.dart';
import '../utils/utils.dart';

class YTLive{
  static Widget ytLive(
      BuildContext context,
      Map<String, String> YTLiveContent,
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
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                width: ScreenConfig.widthPercent*95,
                height: ScreenConfig.heightPercent*80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppTheme().menu_bg_color,
                ),
                child: Column(
                  children: [
                    Text(
                      translate('yt_live.title'),
                      style: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: ScreenConfig.widthPercent*35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    YTLiveContent['yt_live_mn']!,
                                    // translate('yt_live.mn'),
                                    style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        launchUrl(Uri.parse(YTLiveContent['yt_live_link']!));
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.youtube,
                                        color: Colors.white,
                                        size: 30,
                                      )
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                "${translate('yt_live.rn')}:    ${YTLiveContent['yt_live_rn']}",
                                style: TextStyle(
                                    fontSize: Utils().fontSizeMultiplier(20),
                                    color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${translate('yt_live.date')}:    ${YTLiveContent['yt_live_date']}",
                                style: TextStyle(
                                  fontSize: Utils().fontSizeMultiplier(20),
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${translate('yt_live.time')}:    ${YTLiveContent['yt_live_time']} UTC",
                                style: TextStyle(
                                  fontSize: Utils().fontSizeMultiplier(20),
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${translate('yt_live.ls')}:    ${YTLiveContent['yt_live_ls']}",
                                style: TextStyle(
                                  fontSize: Utils().fontSizeMultiplier(20),
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${translate('yt_live.link')}:",
                                style: TextStyle(
                                  fontSize: Utils().fontSizeMultiplier(22),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30, right: 50),
                                child: TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300.withOpacity(0.5),
                                    hintText: translate('yt_live.code'),
                                    hintStyle: const TextStyle(color: Colors.white),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenConfig.heightPercent*10,
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
                                        width: ScreenConfig.widthPercent*25,
                                        height: ScreenConfig.heightPercent*4,
                                        child: Center(
                                          child: Text(
                                              translate('launch_tab.vlg'),
                                              style: TextStyle(
                                                fontSize: Utils().fontSizeMultiplier(17),
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
                        SizedBox(
                          width: ScreenConfig.widthPercent*50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    translate('yt_live.inst'),
                                    style: const TextStyle(
                                        fontSize: 30,
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
                                translate('yt_live.inst_01'),
                                style: TextStyle(
                                    fontSize: Utils().fontSizeMultiplier(15),
                                    color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                translate('yt_live.inst_02'),
                                style: TextStyle(
                                    fontSize: Utils().fontSizeMultiplier(15),
                                    color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: ScreenConfig.widthPercent*36,
                                    height: ScreenConfig.widthPercent*36*0.4563,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(ImagePaths.yt),
                                        fit: BoxFit.fill
                                      )
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                translate('yt_live.inst_03'),
                                style: TextStyle(
                                    fontSize: Utils().fontSizeMultiplier(15),
                                    color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                translate('yt_live.inst_04'),
                                style: TextStyle(
                                    fontSize: Utils().fontSizeMultiplier(15),
                                    color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                translate('yt_live.inst_05'),
                                style: TextStyle(
                                    fontSize: Utils().fontSizeMultiplier(15),
                                    color: Colors.white,
                                ),
                              ),
                            ],
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
