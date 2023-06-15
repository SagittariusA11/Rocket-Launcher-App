import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../utils/utils.dart';
import '../../config/appTheme.dart';

class LaunchView extends StatefulWidget {
  const LaunchView({Key? key}) : super(key: key);

  @override
  State<LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> with SingleTickerProviderStateMixin {
  int length = 10;
  ScrollController upcomingScrollController = ScrollController();
  ScrollController pastScrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      upcomingScrollController.jumpTo(ScreenConfig.heightPercent*60);
      pastScrollController.jumpTo(ScreenConfig.heightPercent*50);
    });
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
                    selectedAppTheme.isLightMode? ImagePaths.launch_bg_light:
                    selectedAppTheme.isDarkMode? ImagePaths.launch_bg_dark:
                    selectedAppTheme.isRedMode? ImagePaths.launch_bg_red:
                    selectedAppTheme.isGreenMode? ImagePaths.launch_bg_green:
                    ImagePaths.launch_bg_blue,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translate('launch_tab.upm'),
                      style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontSize: Utils().fontSizeMultiplier(30),
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: ScreenConfig.heightPercent*30,
                      width: ScreenConfig.widthPercent*85,
                      child: _buildUpcomingCard()
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translate('launch_tab.pm'),
                      style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontSize: Utils().fontSizeMultiplier(30),
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                        height: ScreenConfig.heightPercent*25,
                        width: ScreenConfig.widthPercent*85,
                        child: _buildPastCard()
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: ScreenConfig.widthPercent*5,
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
                        width: ScreenConfig.widthPercent*5,
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
  Widget _buildUpcomingItemList(BuildContext context, int index){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: ScreenConfig.heightPercent*30,
          width: ScreenConfig.heightPercent*30*0.385,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagePaths.rocket),
              fit: BoxFit.fill
            )
          ),
        ),
        Container(
          height: ScreenConfig.heightPercent*25,
          width: ScreenConfig.heightPercent*30*0.615,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme().bg_color.withOpacity(0.5),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    translate('launch_tab.mn'),
                    style: TextStyle(
                        fontSize: Utils().fontSizeMultiplier(20),
                        color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translate('launch_tab.date'),
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(18),
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    translate('launch_tab.rn'),
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(18),
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    translate('launch_tab.ls'),
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(18),
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildUpcomingCard() {
    return ScrollSnapList(
      listController: upcomingScrollController,
      itemBuilder: _buildUpcomingItemList,
      itemSize: ScreenConfig.heightPercent*30,
      dynamicItemSize: true,
      dynamicItemOpacity: 0.75,
      itemCount: length,
    );
  }
  Widget _buildPastItemList(BuildContext context, int index){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: ScreenConfig.heightPercent*25,
          width: ScreenConfig.heightPercent*25*0.385,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePaths.rocket),
                  fit: BoxFit.fill
              ),
          ),
        ),
        Container(
          height: ScreenConfig.heightPercent*20,
          width: ScreenConfig.heightPercent*25*0.615,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppTheme().bg_color.withOpacity(0.5),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  translate('launch_tab.mn'),
                  style: TextStyle(
                    fontSize: Utils().fontSizeMultiplier(17),
                    color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translate('launch_tab.date'),
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(15),
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    translate('launch_tab.rn'),
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(15),
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    translate('launch_tab.ls'),
                    style: TextStyle(
                      fontSize: Utils().fontSizeMultiplier(15),
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPastCard() {
    return ScrollSnapList(
      listController: pastScrollController,
      itemBuilder: _buildPastItemList,
      itemSize: ScreenConfig.heightPercent*25,
      dynamicItemSize: true,
      dynamicItemOpacity: 0.75,
      itemCount: length,
    );
  }
}