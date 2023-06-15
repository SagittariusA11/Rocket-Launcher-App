import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../utils/utils.dart';
import '../../config/appTheme.dart';

class LaunchInfo extends StatefulWidget {
  const LaunchInfo({Key? key}) : super(key: key);

  @override
  State<LaunchInfo> createState() => _LaunchInfoState();
}

class _LaunchInfoState extends State<LaunchInfo> {

  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: ScreenConfig.width,
          height: ScreenConfig.height,
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: ScreenConfig.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.white, width: 1)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: ScreenConfig.widthPercent*12,
                                  child: TextFormField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        hintText: translate('inventory.search'),
                                        hintStyle: TextStyle(
                                            color: Colors.white
                                        ),
                                        border: InputBorder.none
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _isSearching = value.isNotEmpty;
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: _isSearching ? () { } : null,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () { },
                            child: const Icon(
                              Icons.filter_list,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () { },
                            child: const Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                height: ScreenConfig.heightPercent*58,
                width: ScreenConfig.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppTheme().bg_color.withOpacity(0.5),
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
                  SizedBox(
                    width: 30,
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
                  SizedBox(
                    width: 30,
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
    );
  }
}
