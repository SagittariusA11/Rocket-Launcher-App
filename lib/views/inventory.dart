import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:rocket_launcher_app/views/moreInfoView/rocketsInfo.dart';
import 'package:rocket_launcher_app/views/moreInfoView/payloadInfo.dart';
import 'package:rocket_launcher_app/views/searchScreen.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../config/screenConfig.dart';
import '../config/imagePaths.dart';
import '../data/inventory_response.dart';
import '../main.dart';
import '../utils/utils.dart';
import '../config/appTheme.dart';
import '../view models/inventoryViewModel.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({Key? key}) : super(key: key);

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> with SingleTickerProviderStateMixin {

  ScrollController rocketScrollController = ScrollController();
  ScrollController satelliteScrollController = ScrollController();
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

  Future<List<RocketListInventory>>? _allRocketsFuture;
  Future<List<StarlinkListInventory>>? _allStarlinkFuture;
  ScrollController allRocketsScrollController = ScrollController();
  ScrollController allStarlinkScrollController = ScrollController();
  late String starlinkGLB;
  late String starlinkUSDZ;
  late Object starlinkOBJ;

  @override
  void initState() {
    super.initState();
    starlinkGLB = "assets/satellites/starlink_spacex_satellite.glb";
    starlinkUSDZ = "assets/satellites/Starlink_Spacex_Satellite.usdz";
    starlinkOBJ = Object(fileName: "assets/satellites/starlink.obj");
    _allRocketsFuture = InventoryService.fetchallRockets();
    _allStarlinkFuture = InventoryService.fetchallStarlink();
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
          color: AppTheme().bg_color,
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage(
          //           selectedAppTheme.isLightMode? ImagePaths.launch_bg_light:
          //           selectedAppTheme.isDarkMode? ImagePaths.launch_bg_dark:
          //           selectedAppTheme.isRedMode? ImagePaths.launch_bg_red:
          //           selectedAppTheme.isGreenMode? ImagePaths.launch_bg_green:
          //           ImagePaths.launch_bg_blue,
          //         ),
          //         fit: BoxFit.cover
          //     )
          // ),
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
                              color: AppTheme().ht_color,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppTheme().ebtn_color,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme().menu_bg_color,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                connectionStatus
                                    ? translate('connection.connected')
                                    : translate('connection.disconnected'),
                                style: TextStyle(
                                    fontSize: Utils().fontSizeMultiplier(20),
                                    color: AppTheme().ht_color
                                ),
                              ),
                              connectionStatus
                                  ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20,
                              )
                                  : Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => SearchScreen(),
                        //       ),
                        //     );
                        //
                        //   },
                        //   child: Container(
                        //     width: ScreenConfig.widthPercent*12,
                        //     margin: const EdgeInsets.symmetric(horizontal: 30),
                        //     padding: const EdgeInsets.only(bottom: 5),
                        //     decoration: BoxDecoration(
                        //       border: Border(bottom: BorderSide(color: AppTheme().primary_color, width: 1)),
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Icon(
                        //           Icons.search,
                        //           color: AppTheme().primary_color,
                        //           size: 30,
                        //         ),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         Text(
                        //           translate('inventory.search'),
                        //           style: TextStyle(
                        //               color: AppTheme().ht_color,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   margin: const EdgeInsets.only(left: 20),
                  //   width: ScreenConfig.widthPercent*20,
                  //   height: ScreenConfig.heightPercent*77,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(40),
                  //     color: AppTheme().cards_color.withAlpha(50),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 25),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               translate('inventory.rockets'),
                  //               style: TextStyle(
                  //                   fontFamily: 'GoogleSans',
                  //                   fontSize: Utils().fontSizeMultiplier(20),
                  //                   color: AppTheme().ht_color,
                  //                   fontWeight: FontWeight.bold
                  //               ),
                  //             ),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   isSpaceXRocketsChecked = !isSpaceXRocketsChecked;
                  //                 });
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   Transform.scale(
                  //                     scale: 1.1,
                  //                     child: Checkbox(
                  //                       value: isSpaceXRocketsChecked,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           isSpaceXRocketsChecked = value!;
                  //                         });
                  //                       },
                  //                       // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  //                       //   return Colors.grey;
                  //                       // }),
                  //                       activeColor: AppTheme().primary_color,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     translate('inventory.spacex'),
                  //                     style: TextStyle(
                  //                       fontSize: Utils().fontSizeMultiplier(20),
                  //                       fontWeight: FontWeight.w400,
                  //                       color: AppTheme().ht_color,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   isNASARocketsChecked = !isNASARocketsChecked;
                  //                 });
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   Transform.scale(
                  //                     scale: 1.1,
                  //                     child: Checkbox(
                  //                       value: isNASARocketsChecked,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           isNASARocketsChecked = value!;
                  //                         });
                  //                       },
                  //                       // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  //                       //   return Colors.grey;
                  //                       // }),
                  //                       activeColor: AppTheme().primary_color,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     translate('inventory.nasa'),
                  //                     style: TextStyle(
                  //                       fontSize: Utils().fontSizeMultiplier(20),
                  //                       fontWeight: FontWeight.w400,
                  //                       color: AppTheme().ht_color,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   isOthersRocketsChecked = !isOthersRocketsChecked;
                  //                 });
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   Transform.scale(
                  //                     scale: 1.1,
                  //                     child: Checkbox(
                  //                       value: isOthersRocketsChecked,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           isOthersRocketsChecked = value!;
                  //                         });
                  //                       },
                  //                       // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  //                       //   return Colors.grey;
                  //                       // }),
                  //                       activeColor: AppTheme().primary_color,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     translate('inventory.others'),
                  //                     style: TextStyle(
                  //                       fontSize: Utils().fontSizeMultiplier(20),
                  //                       fontWeight: FontWeight.w400,
                  //                       color: AppTheme().ht_color,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   isAllRocketsChecked = !isAllRocketsChecked;
                  //                 });
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   Transform.scale(
                  //                     scale: 1.1,
                  //                     child: Checkbox(
                  //                       value: isAllRocketsChecked,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           isAllRocketsChecked = value!;
                  //                         });
                  //                       },
                  //                       // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  //                       //   return Colors.grey;
                  //                       // }),
                  //                       activeColor: AppTheme().primary_color,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     translate('inventory.all'),
                  //                     style: TextStyle(
                  //                       fontSize: Utils().fontSizeMultiplier(20),
                  //                       fontWeight: FontWeight.w400,
                  //                       color: AppTheme().ht_color,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 25),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               translate('inventory.satellites'),
                  //               style: TextStyle(
                  //                   fontFamily: 'GoogleSans',
                  //                   fontSize: Utils().fontSizeMultiplier(20),
                  //                   color: AppTheme().ht_color,
                  //                   fontWeight: FontWeight.bold
                  //               ),
                  //             ),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   isSpaceXSatellitesChecked = !isSpaceXSatellitesChecked;
                  //                 });
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   Transform.scale(
                  //                     scale: 1.1,
                  //                     child: Checkbox(
                  //                       value: isSpaceXSatellitesChecked,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           isSpaceXSatellitesChecked = value!;
                  //                         });
                  //                       },
                  //                       // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  //                       //   return Colors.grey;
                  //                       // }),
                  //                       activeColor: AppTheme().primary_color,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     translate('inventory.spacex'),
                  //                     style: TextStyle(
                  //                       fontSize: Utils().fontSizeMultiplier(20),
                  //                       fontWeight: FontWeight.w400,
                  //                       color: AppTheme().ht_color,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   isNASASatellitesChecked = !isNASASatellitesChecked;
                  //                 });
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   Transform.scale(
                  //                     scale: 1.1,
                  //                     child: Checkbox(
                  //                       value: isNASASatellitesChecked,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           isNASASatellitesChecked = value!;
                  //                         });
                  //                       },
                  //                       // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  //                       //   return Colors.grey;
                  //                       // }),
                  //                       activeColor: AppTheme().primary_color,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     translate('inventory.nasa'),
                  //                     style: TextStyle(
                  //                       fontSize: Utils().fontSizeMultiplier(20),
                  //                       fontWeight: FontWeight.w400,
                  //                       color: AppTheme().ht_color,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   isStarlinkSatellitesChecked = !isStarlinkSatellitesChecked;
                  //                 });
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   Transform.scale(
                  //                     scale: 1.1,
                  //                     child: Checkbox(
                  //                       value: isStarlinkSatellitesChecked,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           isStarlinkSatellitesChecked = value!;
                  //                         });
                  //                       },
                  //                       // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  //                       //   return Colors.grey;
                  //                       // }),
                  //                       activeColor: AppTheme().primary_color,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     translate('inventory.starlink'),
                  //                     style: TextStyle(
                  //                       fontSize: Utils().fontSizeMultiplier(20),
                  //                       fontWeight: FontWeight.w400,
                  //                       color: AppTheme().ht_color,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   isGeostationarySatellitesChecked = !isGeostationarySatellitesChecked;
                  //                 });
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   Transform.scale(
                  //                     scale: 1.1,
                  //                     child: Checkbox(
                  //                       value: isGeostationarySatellitesChecked,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           isGeostationarySatellitesChecked = value!;
                  //                         });
                  //                       },
                  //                       // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  //                       //   return Colors.grey;
                  //                       // }),
                  //                       activeColor: AppTheme().primary_color,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     translate('inventory.geo'),
                  //                     style: TextStyle(
                  //                       fontSize: Utils().fontSizeMultiplier(20),
                  //                       fontWeight: FontWeight.w400,
                  //                       color: AppTheme().ht_color,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   isOthersSatellitesChecked = !isOthersSatellitesChecked;
                  //                 });
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   Transform.scale(
                  //                     scale: 1.1,
                  //                     child: Checkbox(
                  //                       value: isOthersSatellitesChecked,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           isOthersSatellitesChecked = value!;
                  //                         });
                  //                       },
                  //                       // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  //                       //   return Colors.grey;
                  //                       // }),
                  //                       activeColor: AppTheme().primary_color,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     translate('inventory.others'),
                  //                     style: TextStyle(
                  //                       fontSize: Utils().fontSizeMultiplier(20),
                  //                       fontWeight: FontWeight.w400,
                  //                       color: AppTheme().ht_color,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   isAllSatellitesChecked = !isAllSatellitesChecked;
                  //                 });
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   Transform.scale(
                  //                     scale: 1.1,
                  //                     child: Checkbox(
                  //                       value: isAllSatellitesChecked,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           isAllSatellitesChecked = value!;
                  //                         });
                  //                       },
                  //                       // fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  //                       //   return Colors.grey;
                  //                       // }),
                  //                       activeColor: AppTheme().primary_color,
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     translate('inventory.all'),
                  //                     style: TextStyle(
                  //                       fontSize: Utils().fontSizeMultiplier(20),
                  //                       fontWeight: FontWeight.w400,
                  //                       color: AppTheme().ht_color,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 20),
                        child: Stack(
                          children: [
                            SizedBox(
                                height: ScreenConfig.heightPercent*37,
                                width: ScreenConfig.widthPercent*95,
                                child: _buildRocketsCard()
                            ),
                            Text(
                              translate('inventory.rockets'),
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: Utils().fontSizeMultiplier(30),
                                  color: AppTheme().ht_color,
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
                                width: ScreenConfig.widthPercent*95,
                                child: _buildSatellitesCard()
                            ),
                            Text(
                              translate('inventory.satellites'),
                              style: TextStyle(
                                  fontFamily: 'GoogleSans',
                                  fontSize: Utils().fontSizeMultiplier(30),
                                  color: AppTheme().ht_color,
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
                      //           primary: AppTheme().primary_color,
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

  // static Widget RocketsItemList(){
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Container(
  //         height: ScreenConfig.heightPercent*40,
  //         width: ScreenConfig.heightPercent*37*0.385,
  //         decoration: const BoxDecoration(
  //             image: DecorationImage(
  //                 image: AssetImage(ImagePaths.rocket),
  //                 fit: BoxFit.fill
  //             )
  //         ),
  //       ),
  //       Container(
  //         height: ScreenConfig.heightPercent*29,
  //         width: ScreenConfig.heightPercent*35*0.615,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(25),
  //           color: AppTheme().primary_color.withOpacity(0.5),
  //         ),
  //         child: Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Text(
  //                 translate('inventory.rn'),
  //                 style: TextStyle(
  //                   fontSize: 23,
  //                   color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   translate('inventory.date'),
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   translate('inventory.comp'),
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   translate('inventory.c'),
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   translate('inventory.s'),
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget _buildRocketsCard() {
    return FutureBuilder<List<RocketListInventory>>(
      future: _allRocketsFuture,
      builder: (BuildContext context, AsyncSnapshot<List<RocketListInventory>> snapshot) {
        if (snapshot.hasData) {
          final _allRockets = snapshot.data!;
          return ScrollSnapList(
            listController: allRocketsScrollController,
            itemBuilder: (BuildContext context, int index) {
              final allRocket = _allRockets[index];
              return GestureDetector(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context) => RocketsInfo(
                          RocketID: allRocket.rocketID
                        )
                    );
                  },
                  child: BuildRocketsItemList(allRockets: allRocket)
              );
            },
            itemSize: ScreenConfig.heightPercent*36.925,
            dynamicItemSize: true,
            dynamicItemOpacity: 0.75,
            itemCount: _allRockets.length,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // static Widget SatellitesItemList(){
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Container(
  //         height: ScreenConfig.heightPercent*33,
  //         width: ScreenConfig.heightPercent*28*0.385,
  //         decoration: const BoxDecoration(
  //             image: DecorationImage(
  //                 image: AssetImage(ImagePaths.satellites),
  //                 fit: BoxFit.fill
  //             )
  //         ),
  //       ),
  //       Container(
  //         height: ScreenConfig.heightPercent*23,
  //         width: ScreenConfig.heightPercent*28*0.615,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(18),
  //           color: AppTheme().primary_color.withOpacity(0.5),
  //         ),
  //         child: Column(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Text(
  //                 translate('inventory.sn'),
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   translate('inventory.date'),
  //                   style: TextStyle(
  //                     fontSize: 17,
  //                     color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   translate('inventory.comp'),
  //                   style: TextStyle(
  //                     fontSize: 18,
  //                     color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   translate('inventory.c'),
  //                   style: TextStyle(
  //                     fontSize: 18,
  //                     color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   translate('inventory.type'),
  //                   style: TextStyle(
  //                     fontSize: 18,
  //                     color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget _buildSatellitesCard() {
    return FutureBuilder<List<StarlinkListInventory>>(
      future: _allStarlinkFuture,
      builder: (BuildContext context, AsyncSnapshot<List<StarlinkListInventory>> snapshot) {
        if (snapshot.hasData) {
          final _allStarlinks = snapshot.data!;
          return ScrollSnapList(
            listController: allStarlinkScrollController,
            itemBuilder: (BuildContext context, int index) {
              final allStarlink = _allStarlinks[index];
              return GestureDetector(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context) => PayloadInfo(
                            // RocketID: allStarlink.rocketID
                        )
                    );
                  },
                  child: BuildStarlinksItemList(
                    allStarlink: allStarlink,
                    starlinkGLB: starlinkGLB,
                    starlinkUSDZ: starlinkUSDZ,
                    starlinkOBJ: starlinkOBJ,
                  )
              );
            },
            itemSize: ScreenConfig.heightPercent*28,
            dynamicItemSize: true,
            dynamicItemOpacity: 0.75,
            itemCount: _allStarlinks.length,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class BuildRocketsItemList extends StatelessWidget {
  const BuildRocketsItemList({Key? key, required this.allRockets}) : super(key: key);

  final RocketListInventory allRockets;

  @override
  Widget build(BuildContext context) {
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
            color: AppTheme().cards_color
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  allRockets.rocketName,
                  // translate('inventory.rn'),
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
                    allRockets.firstFlight,
                    // translate('inventory.date'),
                    style: TextStyle(
                      fontSize: 20,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    // translate('inventory.comp'),
                    allRockets.company,
                    style: TextStyle(
                      fontSize: 20,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    // translate('inventory.c'),
                    allRockets.country,
                    style: TextStyle(
                      fontSize: 20,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${translate('inventory.s')}: ${allRockets.stages}",
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
}

class BuildStarlinksItemList extends StatelessWidget {
  BuildStarlinksItemList({
    Key? key,
    required this.allStarlink,
    required this.starlinkGLB,
    required this.starlinkUSDZ,
    required this.starlinkOBJ
  }) : super(key: key);

  final StarlinkListInventory allStarlink;
  String starlinkGLB;
  String starlinkUSDZ;
  Object starlinkOBJ;


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: ScreenConfig.heightPercent*33,
          width: ScreenConfig.heightPercent*28*0.385,
          // decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage(ImagePaths.satellites),
          //         fit: BoxFit.fill
          //     )
          // ),
          child: Cube(
            onSceneCreated: (Scene scene) {
              scene.world.add(starlinkOBJ);
              scene.camera.zoom = 10;
            },
          ),
          // child: ModelViewer(
          //   backgroundColor: AppTheme().bg_color,
          //   src: 'assets/satellites/starlink_spacex_satellite.glb',
          //   alt: 'A 3D model Starlink',
          //   ar: true,
          //   autoRotate: true,
          //   iosSrc: starlinkUSDZ,
          //   disableZoom: true,
          // ),
        ),
        Container(
          height: ScreenConfig.heightPercent*23,
          width: ScreenConfig.heightPercent*28*0.615,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppTheme().cards_color
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  allStarlink.satName,
                  // translate('inventory.sn'),
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
                    allStarlink.launchDate,
                    // translate('inventory.date'),
                    style: TextStyle(
                      fontSize: 17,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${translate('inventory.height')}: ${allStarlink.height}  Km",
                    style: TextStyle(
                      fontSize: 15,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${translate('inventory.velocity')}: ${allStarlink.velocity}  Kms",
                    style: TextStyle(
                      fontSize: 15,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${translate('inventory.site')}: ${allStarlink.site}",
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
}



