import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../config/screenConfig.dart';
import '../config/imagePaths.dart';
import '../utils/utils.dart';
import '../config/appTheme.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({Key? key}) : super(key: key);

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> with SingleTickerProviderStateMixin {
  int length = 10;
  ScrollController rocketScrollController = ScrollController();
  ScrollController satelliteScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      rocketScrollController.jumpTo(ScreenConfig.heightPercent*35);
      satelliteScrollController.jumpTo(ScreenConfig.heightPercent*56);
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
                padding: const EdgeInsets.only(top: 10, left: 20),
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
                      translate('inventory.title'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: ScreenConfig.widthPercent*20,
                    height: ScreenConfig.heightPercent*75,
                    color: Colors.green,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: SizedBox(
                            height: ScreenConfig.heightPercent*35,
                            width: ScreenConfig.widthPercent*75,
                            child: _buildRocketsCard()
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: SizedBox(
                            height: ScreenConfig.heightPercent*28,
                            width: ScreenConfig.widthPercent*75,
                            child: _buildSatellitesCard()
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                          SizedBox(width: ScreenConfig.widthPercent*5,)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }

  Widget _buildRocketsItemList(BuildContext context, int index){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: ScreenConfig.heightPercent*35,
          width: ScreenConfig.heightPercent*35*0.385,
          color: Colors.green,
        ),
        Container(
          height: ScreenConfig.heightPercent*29,
          width: ScreenConfig.heightPercent*35*0.615,
          color: Colors.blue,
        )
      ],
    );
  }

  Widget _buildRocketsCard() {
    return ScrollSnapList(
      listController: rocketScrollController,
      itemBuilder: _buildRocketsItemList,
      itemSize: ScreenConfig.heightPercent*35,
      dynamicItemSize: true,
      dynamicItemOpacity: 0.75,
      itemCount: length,
    );
  }
  Widget _buildSatellitesItemList(BuildContext context, int index){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: ScreenConfig.heightPercent*28,
          width: ScreenConfig.heightPercent*28*0.385,
          color: Colors.green,
        ),
        Container(
          height: ScreenConfig.heightPercent*26,
          width: ScreenConfig.heightPercent*28*0.615,
          color: Colors.blue,
        )
      ],
    );
  }

  Widget _buildSatellitesCard() {
    return ScrollSnapList(
      listController: satelliteScrollController,
      itemBuilder: _buildSatellitesItemList,
      itemSize: ScreenConfig.heightPercent*28,
      dynamicItemSize: true,
      dynamicItemOpacity: 0.75,
      itemCount: length,
    );
  }
}

