import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:rocket_launcher_app/views/moreInfoView/rocketsInfo.dart';
import 'package:rocket_launcher_app/views/moreInfoView/payloadInfo.dart';
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
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool isSpaceXRocketsChecked = false;
  bool isNASARocketsChecked = false;
  bool isOthersRocketsChecked = false;
  bool isAllRocketsChecked = true;
  bool isSpaceXSatellitesChecked = false;
  bool isNASASatellitesChecked = false;
  bool isOthersSatellitesChecked = false;
  bool isStarlinkSatellitesChecked = false;
  bool isGeostationarySatellitesChecked = false;
  bool isAllSatellitesChecked = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      rocketScrollController.jumpTo(ScreenConfig.heightPercent*37);
      satelliteScrollController.jumpTo(ScreenConfig.heightPercent*58);
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: ScreenConfig.widthPercent*20,
                    height: ScreenConfig.heightPercent*77,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppTheme().bg_color.withOpacity(0.75),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translate('inventory.rockets'),
                                style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    fontSize: Utils().fontSizeMultiplier(20),
                                    color: AppTheme().text,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSpaceXRocketsChecked = !isSpaceXRocketsChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Checkbox(
                                        value: isSpaceXRocketsChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isSpaceXRocketsChecked = value!;
                                          });
                                        },
                                        // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                        //   return Colors.grey;
                                        // }),
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      translate('inventory.spacex'),
                                      style: TextStyle(
                                        fontSize: Utils().fontSizeMultiplier(20),
                                        fontWeight: FontWeight.w400,
                                        color: AppTheme().text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isNASARocketsChecked = !isNASARocketsChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Checkbox(
                                        value: isNASARocketsChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isNASARocketsChecked = value!;
                                          });
                                        },
                                        // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                        //   return Colors.grey;
                                        // }),
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      translate('inventory.nasa'),
                                      style: TextStyle(
                                        fontSize: Utils().fontSizeMultiplier(20),
                                        fontWeight: FontWeight.w400,
                                        color: AppTheme().text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isOthersRocketsChecked = !isOthersRocketsChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Checkbox(
                                        value: isOthersRocketsChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isOthersRocketsChecked = value!;
                                          });
                                        },
                                        // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                        //   return Colors.grey;
                                        // }),
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      translate('inventory.others'),
                                      style: TextStyle(
                                        fontSize: Utils().fontSizeMultiplier(20),
                                        fontWeight: FontWeight.w400,
                                        color: AppTheme().text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAllRocketsChecked = !isAllRocketsChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Checkbox(
                                        value: isAllRocketsChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isAllRocketsChecked = value!;
                                          });
                                        },
                                        // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                        //   return Colors.grey;
                                        // }),
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      translate('inventory.all'),
                                      style: TextStyle(
                                        fontSize: Utils().fontSizeMultiplier(20),
                                        fontWeight: FontWeight.w400,
                                        color: AppTheme().text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translate('inventory.satellites'),
                                style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    fontSize: Utils().fontSizeMultiplier(20),
                                    color: AppTheme().text,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSpaceXSatellitesChecked = !isSpaceXSatellitesChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Checkbox(
                                        value: isSpaceXSatellitesChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isSpaceXSatellitesChecked = value!;
                                          });
                                        },
                                        // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                        //   return Colors.grey;
                                        // }),
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      translate('inventory.spacex'),
                                      style: TextStyle(
                                        fontSize: Utils().fontSizeMultiplier(20),
                                        fontWeight: FontWeight.w400,
                                        color: AppTheme().text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isNASASatellitesChecked = !isNASASatellitesChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Checkbox(
                                        value: isNASASatellitesChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isNASASatellitesChecked = value!;
                                          });
                                        },
                                        // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                        //   return Colors.grey;
                                        // }),
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      translate('inventory.nasa'),
                                      style: TextStyle(
                                        fontSize: Utils().fontSizeMultiplier(20),
                                        fontWeight: FontWeight.w400,
                                        color: AppTheme().text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isStarlinkSatellitesChecked = !isStarlinkSatellitesChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Checkbox(
                                        value: isStarlinkSatellitesChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isStarlinkSatellitesChecked = value!;
                                          });
                                        },
                                        // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                        //   return Colors.grey;
                                        // }),
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      translate('inventory.starlink'),
                                      style: TextStyle(
                                        fontSize: Utils().fontSizeMultiplier(20),
                                        fontWeight: FontWeight.w400,
                                        color: AppTheme().text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isGeostationarySatellitesChecked = !isGeostationarySatellitesChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Checkbox(
                                        value: isGeostationarySatellitesChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isGeostationarySatellitesChecked = value!;
                                          });
                                        },
                                        // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                        //   return Colors.grey;
                                        // }),
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      translate('inventory.geo'),
                                      style: TextStyle(
                                        fontSize: Utils().fontSizeMultiplier(20),
                                        fontWeight: FontWeight.w400,
                                        color: AppTheme().text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isOthersSatellitesChecked = !isOthersSatellitesChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Checkbox(
                                        value: isOthersSatellitesChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isOthersSatellitesChecked = value!;
                                          });
                                        },
                                        // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                        //   return Colors.grey;
                                        // }),
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      translate('inventory.others'),
                                      style: TextStyle(
                                        fontSize: Utils().fontSizeMultiplier(20),
                                        fontWeight: FontWeight.w400,
                                        color: AppTheme().text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAllSatellitesChecked = !isAllSatellitesChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Checkbox(
                                        value: isAllSatellitesChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isAllSatellitesChecked = value!;
                                          });
                                        },
                                        // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                        //   return Colors.grey;
                                        // }),
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      translate('inventory.all'),
                                      style: TextStyle(
                                        fontSize: Utils().fontSizeMultiplier(20),
                                        fontWeight: FontWeight.w400,
                                        color: AppTheme().text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: Stack(
                          children: [
                            SizedBox(
                                height: ScreenConfig.heightPercent*37,
                                width: ScreenConfig.widthPercent*75,
                                child: _buildRocketsCard()
                            ),
                            Text(
                              translate('inventory.rockets'),
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: Utils().fontSizeMultiplier(30),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: Stack(
                          children: [
                            SizedBox(
                                height: ScreenConfig.heightPercent*30,
                                width: ScreenConfig.widthPercent*75,
                                child: _buildSatellitesCard()
                            ),
                            Text(
                              translate('inventory.satellites'),
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: Utils().fontSizeMultiplier(30),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     ElevatedButton(
                      //         onPressed: () { },
                      //         style: ElevatedButton.styleFrom(
                      //           elevation: 10,
                      //           shadowColor: Colors.grey,
                      //           primary: AppTheme().bg_color,
                      //           padding: EdgeInsets.all(10),
                      //           shape: StadiumBorder(),
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             SizedBox(
                      //               width: ScreenConfig.widthPercent*2,
                      //             ),
                      //             SizedBox(
                      //               width: ScreenConfig.widthPercent*27,
                      //               height: ScreenConfig.heightPercent*5,
                      //               child: Center(
                      //                 child: Text(
                      //                     translate('launch_tab.vlg'),
                      //                     style: TextStyle(
                      //                       fontSize: Utils().fontSizeMultiplier(23),
                      //                       color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                      //                     )),
                      //               ),
                      //             ),
                      //             const Icon(
                      //               Icons.location_pin,
                      //               color: Colors.black,
                      //               size: 35,
                      //             ),
                      //             SizedBox(
                      //               width: ScreenConfig.widthPercent*2,
                      //             ),
                      //           ],
                      //         )
                      //     ),
                      //     SizedBox(width: ScreenConfig.widthPercent*5,)
                      //   ],
                      // )
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }

  static Widget RocketsItemList(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: ScreenConfig.heightPercent*40,
          width: ScreenConfig.heightPercent*37*0.385,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePaths.rocket),
                  fit: BoxFit.fill
              )
          ),
        ),
        Container(
          height: ScreenConfig.heightPercent*29,
          width: ScreenConfig.heightPercent*35*0.615,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppTheme().bg_color.withOpacity(0.5),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  translate('inventory.rn'),
                  style: TextStyle(
                    fontSize: 23,
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
                    translate('inventory.date'),
                    style: TextStyle(
                      fontSize: 20,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    translate('inventory.comp'),
                    style: TextStyle(
                      fontSize: 20,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    translate('inventory.c'),
                    style: TextStyle(
                      fontSize: 20,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    translate('inventory.s'),
                    style: TextStyle(
                      fontSize: 20,
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

  Widget _buildRocketsCard() {
    return ScrollSnapList(
      listController: rocketScrollController,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            showDialog(
                context: context,
                builder: (context) => RocketsInfo.rocketInfo(context)
            );
          },
          child: RocketsItemList(),
        );
      },
      itemSize: ScreenConfig.heightPercent*36.925,
      dynamicItemSize: true,
      dynamicItemOpacity: 0.75,
      itemCount: length,
    );
  }
  static Widget SatellitesItemList(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: ScreenConfig.heightPercent*33,
          width: ScreenConfig.heightPercent*28*0.385,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePaths.satellites),
                  fit: BoxFit.fill
              )
          ),
        ),
        Container(
          height: ScreenConfig.heightPercent*23,
          width: ScreenConfig.heightPercent*28*0.615,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppTheme().bg_color.withOpacity(0.5),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  translate('inventory.sn'),
                  style: TextStyle(
                    fontSize: 20,
                    color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translate('inventory.date'),
                    style: TextStyle(
                      fontSize: 17,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    translate('inventory.comp'),
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    translate('inventory.c'),
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    translate('inventory.type'),
                    style: TextStyle(
                      fontSize: 18,
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

  Widget _buildSatellitesCard() {
    return ScrollSnapList(
      listController: satelliteScrollController,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            showDialog(
                context: context,
                builder: (context) => PayloadInfo.starlinkInfo(context)
            );
          },
          child: SatellitesItemList(),
        );
      },
      itemSize: ScreenConfig.heightPercent*29.925,
      dynamicItemSize: true,
      dynamicItemOpacity: 0.75,
      itemCount: length,
    );
  }
}

