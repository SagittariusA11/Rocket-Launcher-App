import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rocket_launcher_app/views/homeView/tab.dart';
import 'package:rocket_launcher_app/views/moreInfoView/rocketsInfo.dart';
import 'package:rocket_launcher_app/views/ytLive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../data/launches_response.dart';
import '../../main.dart';
import '../../models/KMLModel.dart';
import '../../models/balloonModel/launchBalloonModel.dart';
import '../../models/lookAtModel.dart';
import '../../models/placemarkModel.dart';
import '../../utils/kml/lookAt.dart';
import '../../utils/kml/orbit.dart';
import '../../utils/kml/kml.dart';
import '../../utils/lgTasks.dart';
import '../../utils/services/balloonServices.dart';
import '../../utils/services/lgServices.dart';
import '../../utils/utils.dart';
import '../../config/appTheme.dart';
import '../../view models/homeViewModels/launchViewModel.dart';
import '../searchScreen.dart';

class LaunchInfo extends StatefulWidget {
  const LaunchInfo({Key? key}) : super(key: key);

  @override
  State<LaunchInfo> createState() => _LaunchInfoState();
}

class _LaunchInfoState extends State<LaunchInfo> with SingleTickerProviderStateMixin {

  GlobalKey __LaunchInfoStateKey = GlobalKey();

  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  DateTime? selectedDate;
  DateTimeRange? selectedDateRange;
  var currentLaunch;
  bool isTapped = false;
  late AnimationController _rotationiconcontroller;
  bool isOrbiting = false;
  double latvalue = 28.608373;
  double longvalue = -80.604339;
  PlacemarkModel? _launchPlacemark;
  String finalname = "";
  bool loading = false;
  KML kml = KML("", "");
  String finaltext = "";

  Future<List<AllLaunch>>? _allLaunchesFuture;
  // List<AllLaunch> _allLaunchesFuture = [];
  late final AllLaunch allLaunches;
  bool _isDataLoaded = false;
  CarouselController allCarouselController = CarouselController();

  void _viewAllLaunchStats(LaunchBalloonModel stats, BuildContext context,
      {double orbitPeriod = 2.8, bool updatePosition = true}) async {
    final LaunchBalloonService launchService = LaunchBalloonService();

    final placemark = launchService.buildLaunchPlacemark(
      stats,
      orbitPeriod,
      lookAt: _launchPlacemark != null && !updatePosition
          ? _launchPlacemark!.lookAt
          : null,
      updatePosition: false,
    );
    setState(() {
      _launchPlacemark = placemark;
    });

    try {
      await LgService().clearKml();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    await LGConnection().openDemoLogos();
    await LGConnection().openLaunchBalloon(
        'image',
        currentLaunch.missionName,
        currentLaunch.rocketName,
        currentLaunch.launchDate,
        currentLaunch.launchTime,
        currentLaunch.launchPad,
        currentLaunch.flightNumber,
        currentLaunch.payload,
        currentLaunch.country,
        currentLaunch.missionDes,
        currentLaunch.launchPadFullName,
        translate('launchInfo_tab.lsd_0${currentLaunch.launchPadDes}'),
        currentLaunch.lat,
        currentLaunch.lng
    );

    final kmlBalloon = KMLModel(
      name: 'RLA-Launch-balloon',
      content: placemark.balloonOnlyTag,
    );

    try {
      await LgService().sendKMLToSlave(
        LgService().balloonScreen,
        kmlBalloon.body,
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    if (updatePosition) {
      await LgService().flyTo(LookAtModel(
        longitude: double.parse(currentLaunch.lng),
        latitude: double.parse(currentLaunch.lat),
        range: '1000',
        tilt: '70',
        altitude: 150,
        heading: '45',
        altitudeMode: 'relativeToGround',
      ));
    }

    final orbit = launchService.buildOrbit(
        lookAt: LookAtModel(
          longitude: double.parse(currentLaunch.lng),
          latitude: double.parse(currentLaunch.lat),
          range: '1000',
          tilt: '70',
          altitude: 150,
          heading: '45',
          altitudeMode: 'relativeToGround',
        )
    );

    playOrbit(
        double.parse(currentLaunch.lng),
        double.parse(currentLaunch.lat)
    );

    try {
      await LgService().sendTour(orbit, 'Orbit');
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  // List<Widget> RocketInfoCardList = [];
  //
  // Future<void> buildRocketInfoList() async {
  //   final response = await http.get(Uri.parse('https://api.spacexdata.com/v4/launches'));
  //   if (response.statusCode == 200) {
  //     final launchesJson = json.decode(response.body) as List<dynamic>;
  //     int iteamcount = launchesJson.length;
  //     for(int i = 0; i < iteamcount; i++){
  //       final alllaunch = launchesJson[i];
  //       final Widget RocketInfoCard = BuildRocketInfoItemList(allLaunches: alllaunch);
  //       RocketInfoCardList.add(RocketInfoCard);
  //       print("\n\n5: ${RocketInfoCardList.length}\n\n");
  //       print(iteamcount);
  //     }
  //   }
  // }

  // Widget _buildAllCard(){
  //   return FutureBuilder<List<AllLaunch>>(
  //     future: _allLaunchesFuture,
  //     builder: (BuildContext context, AsyncSnapshot<List<AllLaunch>> snapshot) {
  //       if (snapshot.hasData) {
  //         final _allLaunches = snapshot.data!;
  //         int itemCount = _allLaunches.length;
  //         for(int i = 0; i < itemCount; i++){
  //           final allLaunch = _allLaunches[i];
  //           final Widget rocketInfoCard = BuildRocketInfoItemList(allLaunches: allLaunch);
  //           RocketInfoCardList.add(rocketInfoCard);
  //           print("\n\n5: ${RocketInfoCardList.length}\n\n");
  //           print(itemCount);
  //           return BuildRocketInfoItemList(allLaunches: allLaunch);
  //         }
  //       } else if (snapshot.hasError) {
  //         return Center(
  //           child: Text('Error: ${snapshot.error}'),
  //         );
  //       }
  //       return Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     },
  //   );
  // }


  @override
  void initState() {
    super.initState();
    _rotationiconcontroller = AnimationController(
      duration: const Duration(seconds: 50),
      vsync: this,
    );
    // buildRocketInfoList();
    // _buildAllCard();
    // if (!_isDataLoaded) {
    //   _allLaunchesFuture = LaunchService.fetchAllLaunches();
    //   _isDataLoaded = true;
    // }
    _allLaunchesFuture = LaunchService.fetchAllLaunches();
    // test();
  }
  // void test()async{
  //   _allLaunchesFuture = await LaunchService.fetchAllLaunches();
  //   setState(() {
  //     print("4: $_allLaunchesFuture");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          // width: ScreenConfig.width,
          height: ScreenConfig.height,
          color: AppTheme().bg_color,
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage(
          //           selectedAppTheme.isLightMode? ImagePaths.launchInfo_bg_light:
          //           selectedAppTheme.isDarkMode? ImagePaths.launchInfo_bg_dark:
          //           selectedAppTheme.isRedMode? ImagePaths.launchInfo_bg_red:
          //           selectedAppTheme.isGreenMode? ImagePaths.launchInfo_bg_green:
          //           ImagePaths.launchInfo_bg_blue,
          //         ),
          //         fit: BoxFit.cover
          //     )
          // ),
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
                                    color: AppTheme().ht_color,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                translate('connection.label_l2'),
                                style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    fontSize: Utils().fontSizeMultiplier(20),
                                    color: AppTheme().ht_color,
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
                          // IconButton(
                          //   onPressed: () { print("Filter"); },
                          //   icon: FaIcon(
                          //     FontAwesomeIcons.filter,
                          //     color: AppTheme().ht_color,
                          //     size: 30,
                          //   ),
                          // ),
                          // // const SizedBox(
                          // //   width: 10,
                          // // ),
                          // IconButton(
                          //   onPressed: () {
                          //     showDialog(
                          //         context: context,
                          //         builder: (context) => dateRangePickerButton(context)
                          //     );
                          //     print("Calander");
                          //   },
                          //   icon: Icon(
                          //     Icons.calendar_month_rounded,
                          //     color: AppTheme().ht_color,
                          //     size: 40,
                          //   ),
                          // ),
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
                          //     margin: const EdgeInsets.symmetric(horizontal: 15),
                          //     padding: const EdgeInsets.only(bottom: 5),
                          //     decoration: BoxDecoration(
                          //       border: Border(bottom: BorderSide(color: AppTheme().ht_color, width: 1)),
                          //     ),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Icon(
                          //           Icons.search,
                          //           color: AppTheme().ht_color,
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
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // CarouselSlider(
              //   options: CarouselOptions(
              //     enlargeCenterPage: true,
              //     height: ScreenConfig.heightPercent*62,
              //     initialPage: 0,
              //     scrollDirection: Axis.vertical,
              //     autoPlayInterval: const Duration(milliseconds: 5000),
              //     autoPlay: false,
              //   ),
              //   items: RocketInfoCardList,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                    height: ScreenConfig.heightPercent*61,
                    width: ScreenConfig.width,
                    child: _buildAllCard()
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if(isTapped){
                          showDialog(
                              context: context,
                              builder: (context) => YTLive.ytLive(
                                  context,
                                  {
                                    'yt_live_mn': currentLaunch.missionName,
                                    'yt_live_rn': currentLaunch.rocketName,
                                    'yt_live_date': currentLaunch.launchDate,
                                    'yt_live_time': currentLaunch.launchTime,
                                    'yt_live_ls': currentLaunch.launchPad,
                                    'yt_live_link': currentLaunch.yt
                                  }
                              )
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        backgroundColor: AppTheme().ebtn_color,
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
                                    color: AppTheme().ht_color
                                  )),
                            ),
                          ),
                          Icon(
                            Icons.play_arrow,
                            color: AppTheme().ht_color,
                            size: 35,
                          ),
                          SizedBox(
                            width: ScreenConfig.widthPercent*2,
                          ),
                        ],
                      )
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if(isTapped && connectionStatus){
                          LaunchBalloonModel launch = LaunchBalloonModel(
                            id: 'All Launch',
                            missionName: currentLaunch.missionName,
                            rocketName: currentLaunch.rocketName,
                            date: currentLaunch.launchDate,
                            time: currentLaunch.launchTime,
                            launchSite: currentLaunch.launchPad,
                            flightNumber: currentLaunch.flightNumber,
                            payload: currentLaunch.payload,
                            nationality: currentLaunch.country,
                            missionDescription: currentLaunch.missionDes??"N/A",
                            launchSiteFullName: currentLaunch.launchPadFullName,
                            launchSiteDescription: currentLaunch.launchPadDes,
                          );
                          print(currentLaunch.missionName);
                          print(currentLaunch.rocketName);
                          print(currentLaunch.launchDate);
                          print(currentLaunch.launchTime);
                          print(currentLaunch.launchPad);
                          print(currentLaunch.payload);
                          print(currentLaunch.country);
                          print(currentLaunch.missionDes);
                          print(currentLaunch.launchPadFullName);
                          print(currentLaunch.launchPadDes);
                          print(currentLaunch.lat);
                          print(currentLaunch.lng);
                          _viewAllLaunchStats(launch, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        backgroundColor: AppTheme().ebtn_color,
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
                                    color: AppTheme().ht_color
                                  )),
                            ),
                          ),
                          Icon(
                            Icons.location_pin,
                            color: AppTheme().ht_color,
                            size: 35,
                          ),
                          SizedBox(
                            width: ScreenConfig.widthPercent*2,
                          ),
                        ],
                      )
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                        isOrbiting = !isOrbiting,
                        if (isOrbiting == true)
                          {
                            _rotationiconcontroller.forward(),
                            LGConnection().cleanOrbit().then((value) {
                              playOrbit(longvalue, latvalue).then((value) {
                                _showToast(translate('launch_tab.buildorbit'));
                              });
                            }).catchError((onError) {
                              _rotationiconcontroller.stop();
                              print('oh no $onError');
                              if (onError == 'nogeodata') {
                                showAlertDialog(
                                    translate('launch_tab.alert'),
                                    translate('launch_tab.alert2'));
                              }
                              showAlertDialog(
                                  translate('launch_tab.alert3'),
                                  translate('launch_tab.alert4'));
                            }),
                          }
                        else
                          {
                            _rotationiconcontroller.reset(),
                            stopOrbit().then((value) {
                              _showToast(translate('launch_tab.stoporbit'));
                              LGConnection().cleanOrbit();
                            }).catchError((onError) {
                              print('oh no $onError');
                              if (onError == 'nogeodata') {
                                showAlertDialog(
                                    translate('launch_tab.alert'),
                                    translate('launch_tab.alert2'));
                              }
                              showAlertDialog(
                                  translate('launch_tab.alert3'),
                                  translate('launch_tab.alert4'));
                            }),
                          }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        backgroundColor: AppTheme().ebtn_color,
                        shape: const StadiumBorder(),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 10),
                            height: ScreenConfig.heightPercent*5,
                            child: Center(
                              child: Text(
                                  translate('launch_tab.dlg'),
                                  style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(20),
                                      color: AppTheme().ht_color,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ),
                          ),
                          RotationTransition(
                            turns: Tween(begin: 0.0, end: 25.0)
                                .animate(_rotationiconcontroller),
                            child: Builder(
                              builder: (context) => IconButton(
                                icon: Image.asset(ImagePaths.orbit),
                                iconSize: 40,
                                onPressed: (){},
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              )
            ],
          ),
        )
    );
  }

  Widget dateRangePickerButton(
      BuildContext context,
      ) {
    return AlertDialog(
      title: Text(translate('launch_tab.so')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(translate('launch_tab.sd')),
            onTap: () {
              Navigator.of(context).pop();
              _selectDate();
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_view_day),
            title: Text(translate('launch_tab.sdr')),
            onTap: () {
              Navigator.of(context).pop();
              _selectDateRange();
            },
          ),
        ],
      ),
    );
  }

  playOrbit(double lng, double lat) async {
    await LGConnection()
        .buildOrbit(Orbit.buildOrbit(Orbit.generateOrbitTag(
        LookAtLaunch(
          lng,
          lat
        ))))
        .then((value) async {
      await LGConnection().startOrbit();
    });
    setState(() {
      isOrbiting = true;
    });
  }

  stopOrbit() async {
    await LGConnection().stopOrbit();
    setState(() {
      isOrbiting = false;
    });
  }

  void _showToast(String x) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$x",
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.normal,
              fontFamily: "GoogleSans",
              color: Colors.white),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Color.fromARGB(250, 43, 43, 43),
        width: 500.0,
        padding: const EdgeInsets.fromLTRB(
          35,
          20,
          15,
          20,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        action: SnackBarAction(
          textColor: Color.fromARGB(255, 125, 164, 243),
          label: translate('launch_tab.close'),
          onPressed: () {},
        ),
      ),
    );
  }

  showAlertDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 3),
            child: AlertDialog(
              backgroundColor: Color.fromARGB(255, 33, 33, 33),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Image.asset(
                        "assets/images/sad.png",
                        width: 250,
                        height: 250,
                      )),
                  Text(
                    '$title',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 204, 204, 204),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: 320,
                height: 180,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('$msg',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(
                              255,
                              204,
                              204,
                              204,
                            ),
                          ),
                          textAlign: TextAlign.center),
                      SizedBox(
                          width: 300,
                          child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  shadowColor: Colors.black,
                                  primary: Color.fromARGB(255, 220, 220, 220),
                                  padding: EdgeInsets.all(15),
                                  shape: StadiumBorder(),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Wrap(
                                  children: <Widget>[
                                    Text(translate('dismiss'),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                  ],
                                ),
                              ))),
                    ]),
              ),
            ));
      },
    );
  }

  Widget _buildAllCard(){
    return FutureBuilder<List<AllLaunch>>(
      future: _allLaunchesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<AllLaunch>> snapshot) {
        if (snapshot.hasData) {
          final _allLaunches = snapshot.data!;
          print(_allLaunches.length);
          // return ScrollSnapList(
          //   listController: allScrollController,
          //   itemBuilder: (BuildContext context, int index) {
          //     final alllaunch = _allLaunches[index];
          //     return BuildRocketInfoItemList(allLaunches: alllaunch);
          //   },
          //   itemSize: ScreenConfig.heightPercent*70,
          //   dynamicItemSize: true,
          //   dynamicItemOpacity: 0.75,
          //   itemCount: _allLaunches.length,
          //   scrollDirection: Axis.vertical,
          // );
          return CarouselSlider.builder(
            carouselController: allCarouselController,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              final alllaunch = _allLaunches[index];
              return GestureDetector(
                onTap: () {
                  currentLaunch = alllaunch;
                  setState(() {
                    map_lat = double.parse(currentLaunch.lat);
                    map_lng = double.parse(currentLaunch.lng);
                  });
                  isTapped = true;
                  // print("Here");
                  print(index);
                },
                child: BuildRocketInfoItemList(allLaunches: alllaunch)
              );
            },
            itemCount: _allLaunches.length,
            options: CarouselOptions(
              scrollDirection: Axis.vertical,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
            ),
          );
        } else if (snapshot.hasError) {
          print("snapshot.data: ${snapshot.data?.length}");
          print('Error: ${snapshot.error}');
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

  // Widget _buildAllCard(){
  //   if(_allLaunchesFuture != null){
  //     print("\n\n***$_allLaunchesFuture ***\n\n");
  //     return Container(
  //       child: Text("Working"),
  //     );
  //   } else {
  //     return Text("Here");
  //   }
  // }
}

class BuildRocketInfoItemList extends StatelessWidget {
  const BuildRocketInfoItemList({Key? key, required this.allLaunches}) : super(key: key);

  final AllLaunch allLaunches;
  String _getImagePath(String rocketName) {
    switch (rocketName) {
      case "Falcon 1":
        return ImagePaths.falcon_1;
      case "Falcon 9":
        return ImagePaths.falcon_9;
      case "Falcon Heavy":
        return ImagePaths.falcon_heavy;
      case "Starship":
        return ImagePaths.starhip;
      default:
        return ImagePaths.rocket;
    }
  }

  String _get3DModelPath(String rocketName) {
    switch (rocketName) {
      case "Falcon 1":
        return ImagePaths.falcon_1;
      case "Falcon 9":
        return ModelPaths.falcon_9;
      case "Falcon Heavy":
        return ModelPaths.falcon_heavy;
      case "Starship":
        return ModelPaths.starship;
      default:
        return ImagePaths.rocket;
    }
  }

  Widget showModels(String rocketName){
    if(rocketName == 'Falcon 1'){
      return Container(
        height: ScreenConfig.heightPercent*30,
        width: ScreenConfig.heightPercent*30*0.385,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(_getImagePath(rocketName)),
                fit: BoxFit.fill
            )
        ),
      );
    } else {
      return SizedBox(
        height: ScreenConfig.heightPercent*30,
        width: ScreenConfig.heightPercent*30*0.385,
        child: ModelViewer(
          backgroundColor: Colors.transparent,
          src: _get3DModelPath(rocketName),
          alt: "3D Model of ${rocketName}",
          ar: true,
          autoRotate: false,
          disableZoom: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: ScreenConfig.heightPercent*60,
      // width: ScreenConfig.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppTheme().cards_color.withAlpha(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: ScreenConfig.widthPercent*18,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                allLaunches.missionName,
                  // translate('launchInfo_tab.mn'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'GoogleSans',
                      fontSize: Utils().fontSizeMultiplier(25),
                      color: AppTheme().ht_color,
                      fontWeight: FontWeight.bold
                  ),
                ),
                showModels(allLaunches.rocketName),
                ElevatedButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context) => RocketsInfo(RocketID: allLaunches.rocketID)
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.grey,
                      backgroundColor: AppTheme().ebtn_color,
                      shape: const StadiumBorder(),
                    ),
                    child: SizedBox(
                      width: ScreenConfig.widthPercent*9,
                      height: ScreenConfig.heightPercent*3,
                      child: Center(
                        child: Text(
                            translate('launchInfo_tab.mi'),
                            style: TextStyle(
                              fontSize: Utils().fontSizeMultiplier(20),
                              color: AppTheme().ht_color,
                            )
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: ScreenConfig.heightPercent*56,
              width: ScreenConfig.widthPercent*27,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 5.0, color: AppTheme().primary_color),
                  right: BorderSide(width: 5.0, color: AppTheme().primary_color),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${translate('launchInfo_tab.rn')}:",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                      Text(
                        allLaunches.rocketName,
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${translate('launchInfo_tab.date')}:",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                      Text(
                        allLaunches.launchDate,
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${translate('launchInfo_tab.time')}:",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                      Text(
                        "${allLaunches.launchTime}  UTC",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${translate('launchInfo_tab.ls')}:",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                      Text(
                        allLaunches.launchPad,
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${translate('launchInfo_tab.fn')}:",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                      Text(
                        allLaunches.flightNumber,
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${translate('launchInfo_tab.py')}:",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                      Text(
                        allLaunches.payload,
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${translate('launchInfo_tab.n')}:",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                      if(allLaunches.country == 'Republic of the Marshall Islands')Text(
                        'Marshall Islands',
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                      if(allLaunches.country != 'Republic of the Marshall Islands')Text(
                        allLaunches.country,
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${translate('launchInfo_tab.ct')}:",
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                      Text(
                        allLaunches.company,
                        style: TextStyle(
                          fontSize: 22,
                          color: AppTheme().ht_color,
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   "${translate('launchInfo_tab.orb')}:    ${allLaunches.orbit}",
                  //   style: const TextStyle(
                  //     fontSize: 22,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            launchUrl(Uri.parse(allLaunches.article));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            shadowColor: Colors.grey,
                            backgroundColor: AppTheme().ebtn_color,
                            shape: const StadiumBorder(),
                          ),
                          child: SizedBox(
                            width: ScreenConfig.widthPercent*8,
                            height: ScreenConfig.heightPercent*5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.article,
                                  size: 25,
                                  color: AppTheme().primary_color,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    translate('launchInfo_tab.art'),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppTheme().ht_color,
                                    )
                                ),
                              ],
                            ),
                          )
                      ),
                      ElevatedButton(
                          onPressed: () {
                            launchUrl(Uri.parse(allLaunches.wiki));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            shadowColor: Colors.grey,
                            backgroundColor: AppTheme().ebtn_color,
                            shape: const StadiumBorder(),
                          ),
                          child: SizedBox(
                            width: ScreenConfig.widthPercent*8,
                            height: ScreenConfig.heightPercent*5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.globe,
                                  size: 20,
                                  color: AppTheme().primary_color,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    translate('launchInfo_tab.wiki'),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppTheme().ht_color,
                                    )
                                ),
                              ],
                            ),
                          )
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       print(allLaunches.imgs);
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(builder: (context) => ImageGrid(imgs: allLaunches.imgs)),
                      //       );
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       elevation: 10,
                      //       shadowColor: Colors.grey,
                      //       primary: AppTheme().ebtn_color,
                      //       shape: const StadiumBorder(),
                      //     ),
                      //     child: SizedBox(
                      //       width: ScreenConfig.widthPercent*6,
                      //       height: ScreenConfig.heightPercent*5,
                      //       child: Center(
                      //         child: Text(
                      //             translate('launchInfo_tab.img'),
                      //             style: TextStyle(
                      //               fontSize: 16,
                      //               color: AppTheme().ht_color,
                      //             )
                      //         ),
                      //       ),
                      //     )
                      // ),
                      // ElevatedButton(
                      //     onPressed: () { },
                      //     style: ElevatedButton.styleFrom(
                      //       elevation: 10,
                      //       shadowColor: Colors.grey,
                      //       primary: AppTheme().primary_color,
                      //       shape: const StadiumBorder(),
                      //     ),
                      //     child: SizedBox(
                      //       width: ScreenConfig.widthPercent*5,
                      //       height: ScreenConfig.heightPercent*3,
                      //       child: Center(
                      //         child: Text(
                      //             translate('launchInfo_tab.tl'),
                      //             style: TextStyle(
                      //               fontSize: 16,
                      //               color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                      //             )
                      //         ),
                      //       ),
                      //     )
                      // ),
                    ],
                  )
                ],
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: ScreenConfig.widthPercent*44,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: ScreenConfig.heightPercent*16,
                    width: ScreenConfig.widthPercent*40,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 3.0, color: AppTheme().primary_color),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${translate('launchInfo_tab.md')}:",
                          style: TextStyle(
                            fontSize: 25,
                            color: AppTheme().ht_color,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          allLaunches.missionDes,
                          // translate('launchInfo_tab.md_01'),
                          style: TextStyle(
                            fontSize: 15,
                            color: AppTheme().ht_color,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: ScreenConfig.heightPercent*25,
                    width: ScreenConfig.widthPercent*40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${translate('launchInfo_tab.lsd')}:",
                          style: TextStyle(
                            fontSize: 25,
                            color: AppTheme().ht_color,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          allLaunches.launchPadFullName,
                          // translate('launchInfo_tab.lsfn'),
                          style: TextStyle(
                            fontSize: 20,
                            color: AppTheme().ht_color,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          // translate(allLaunches.launchPadDes),
                          translate('launchInfo_tab.lsd_0${allLaunches.launchPadDes}'),
                          style: TextStyle(
                            fontSize: 15,
                            color: AppTheme().ht_color,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LGConnection {

  Future openLaunchBalloon(
      String image,
      String missionName,
      String rocketName,
      String date,
      String time,
      String launchSite,
      String flightNumber,
      String payload,
      String country,
      String missionDescription,
      String launchSiteFullName,
      String launchSiteDescription,
      String lat,
      String lng
      ) async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );
    int rigs = 3;
    rigs = (int.parse(credencials['numberofrigs']) / 2).floor() + 1;
    String openBalloonKML = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
	<name>Placemark.kml</name>
	<Schema name="KML Data_CSV" id="S_KML_Data_CSV_SSSSSSSSSDDSSSS">
		<SimpleField type="string" name="Mission_Name"><displayName>&lt;b&gt;Mission Name&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="Rocket_Name"><displayName>&lt;b&gt;Rocket Name&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="Mission_Details"><displayName>&lt;b&gt;Mission Details&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="Date"><displayName>&lt;b&gt;Date&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="Time"><displayName>&lt;b&gt;Time&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="Launch_SIte"><displayName>&lt;b&gt;Launch SIte&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="Fligh_Number"><displayName>&lt;b&gt;Fligh Number&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="Payload"><displayName>&lt;b&gt;Payload&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="Nationality"><displayName>&lt;b&gt;Nationality&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="double" name="Latitude"><displayName>&lt;b&gt;Latitude&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="double" name="Longitude"><displayName>&lt;b&gt;Longitude&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="Mission_Description_"><displayName>&lt;b&gt;Mission Description:&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="unnamed"><displayName>&lt;b&gt;&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="Launch_Site_Description_"><displayName>&lt;b&gt;Launch Site Description:&lt;/b&gt;</displayName>
</SimpleField>
		<SimpleField type="string" name="unnamed_2"><displayName>&lt;b&gt;&lt;/b&gt;</displayName>
</SimpleField>
	</Schema>
	<Style id="hlightPointStyle">
		<IconStyle>
			<Icon>
				<href>http://maps.google.com/mapfiles/kml/shapes/placemark_circle_highlight.png</href>
			</Icon>
		</IconStyle>
		<BalloonStyle>
			<text><![CDATA[<table border="0">
  <tr><td><b>Mission Name</b></td><td>$missionName</td></tr>
  <tr><td><b>Rocket Name</b></td><td>$rocketName</td></tr>
  <tr><td><b>Date</b></td><td>$date</td></tr>
  <tr><td><b>Time</b></td><td>$time</td></tr>
  <tr><td><b>Launch Site</b></td><td>$launchSite</td></tr>
  <tr><td><b>Flight Number</b></td><td>$flightNumber</td></tr>
  <tr><td><b>Payload</b></td><td>$payload</td></tr>
  <tr><td><b>Nationality</b></td><td>$country</td></tr>
  <tr><td><b>Latitude</b></td><td>$lat</td></tr>
  <tr><td><b>Longitude</b></td><td>$lng</td></tr>
  <tr><td><b>Mission Description:</b></td><td>$missionDescription</td></tr>
  <tr><td><b></b></td><td></td></tr>
  <tr><td><b>Launch Site Description:</b></td><td>$launchSiteFullName</td></tr>
  <tr><td><b></b></td><td>$launchSiteDescription</td></tr>
</table>
]]></text>
		</BalloonStyle>
	</Style>
	<Style id="normPointStyle">
		<IconStyle>
			<Icon>
				<href>http://maps.google.com/mapfiles/kml/shapes/placemark_circle.png</href>
			</Icon>
		</IconStyle>
		<BalloonStyle>
			<text><![CDATA[<table border="0">
  <tr><td><b>Mission Name</b></td><td>$missionName</td></tr>
  <tr><td><b>Rocket Name</b></td><td>$rocketName</td></tr>
  <tr><td><b>Date</b></td><td>$date</td></tr>
  <tr><td><b>Time</b></td><td>$time</td></tr>
  <tr><td><b>Launch Site</b></td><td>$launchSite</td></tr>
  <tr><td><b>Flight Number</b></td><td>$flightNumber</td></tr>
  <tr><td><b>Payload</b></td><td>$payload</td></tr>
  <tr><td><b>Nationality</b></td><td>$country</td></tr>
  <tr><td><b>Latitude</b></td><td>$lat</td></tr>
  <tr><td><b>Longitude</b></td><td>$lng</td></tr>
  <tr><td><b>Mission Description:</b></td><td>$missionDescription</td></tr>
  <tr><td><b></b></td><td></td></tr>
  <tr><td><b>Launch Site Description:</b></td><td>$launchSiteFullName</td></tr>
  <tr><td><b></b></td><td>$launchSiteDescription</td></tr>
</table>
]]></text>
		</BalloonStyle>
	</Style>
	<StyleMap id="pointStyleMap">
		<Pair>
			<key>normal</key>
			<styleUrl>#normPointStyle</styleUrl>
		</Pair>
		<Pair>
			<key>highlight</key>
			<styleUrl>#hlightPointStyle</styleUrl>
		</Pair>
	</StyleMap>
	<Placemark>
		<styleUrl>#pointStyleMap</styleUrl>
		<ExtendedData>
			<SchemaData schemaUrl="#S_KML_Data_CSV_SSSSSSSSSDDSSSS">
				<SimpleData name="Mission_Name"></SimpleData>
				<SimpleData name="Rocket_Name"></SimpleData>
				<SimpleData name="Mission_Details"></SimpleData>
				<SimpleData name="Date">Date</SimpleData>
				<SimpleData name="Time">Time</SimpleData>
				<SimpleData name="Launch_SIte">Launch SIte</SimpleData>
				<SimpleData name="Fligh_Number">Fligh Number</SimpleData>
				<SimpleData name="Payload">Payload</SimpleData>
				<SimpleData name="Nationality">Nationality</SimpleData>
				<SimpleData name="Latitude">28.6082</SimpleData>
				<SimpleData name="Longitude">-80.6041</SimpleData>
				<SimpleData name="Mission_Description_">Engine failure at 33 seconds and loss of vehicle.</SimpleData>
				<SimpleData name="unnamed"></SimpleData>
				<SimpleData name="Launch_Site_Description_">Kwajalein Atoll Omelek Island</SimpleData>
				<SimpleData name="unnamed_2">SpaceX had tentatively planned to upgrade the launch site for use by the Falcon 9 launch vehicle. As of December 2010, the SpaceX launch manifest listed Omelek (Kwajalein) as a potential site for several Falcon 9 launches, the first in 2012, and the Falcon 9 Overview document offered Kwajalein as a launch option. In any event, SpaceX did not make the upgrades necessary to support Falcon 9 launches from the atoll and did not launch Falcon 9 from Omelek. The Site has since been abandoned by SpaceX.</SimpleData>
			</SchemaData>
		</ExtendedData>
		<gx:balloonVisibility>1</gx:balloonVisibility>
		<Point>
			<coordinates>-80.60405833,28.60819721999998,0</coordinates>
		</Point>
	</Placemark>
</Document>
</kml>
''';
    try {
      await client;
      print("Success");
      return await client.execute(
          "echo '$openBalloonKML' > /var/www/html/kml/slave_$rigs.kml");
    } catch (e) {
      print("Failure");
      return Future.error(e);
    }
  }

  Future sendToLG(String kml, String projectname, String lng, String lat) async {
    if (kml.isNotEmpty) {
      return _createLocalFile(kml, projectname, lng, lat);
    }
    return Future.error('nogeodata');
  }

  Future cleanVisualization() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );

    try {
      await client;
      stopOrbit();
      return await client.execute('> /var/www/html/kmls.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  _getCredentials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String ipAddress = preferences.getString('master_ip') ?? '';
    String password = preferences.getString('master_password') ?? '';
    String portNumber = preferences.getString('master_portNumber') ?? '';
    String username = preferences.getString('master_username') ?? '';
    String numberofrigs = preferences.getString('numberofrigs') ?? '';

    return {
      "ip": ipAddress,
      "pass": password,
      "port": portNumber,
      "username": username,
      "numberofrigs": numberofrigs
    };
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  _createLocalFile(String kml, String projectname, String lng, String lat) async {
    String localPath = await _localPath;
    File localFile = File('$localPath/$projectname.kml');
    localFile.writeAsString(kml);
    File localFile2 = File('$localPath/kmls.txt');
    localFile2.writeAsString(kml);
    return _uploadToLG('$localPath/$projectname.kml', projectname, localFile, lng, lat);
  }

  _uploadToLG(String localPath, String projectname, File finalFile, String lng, String lat) async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );

    LookAtLaunch flyto = LookAtLaunch(
      double.parse(lng),
      double.parse(lat)
    );
    try {
      await client;
      await client.execute('> /var/www/html/kmls.txt');

      // upload kml
      await client;
      final sftp = await client.sftp();
      double anyKindofProgressBar;
      final file = await sftp.open('/var/www/html/$projectname.kml',
          mode: SftpFileOpenMode.create |
          SftpFileOpenMode.truncate |
          SftpFileOpenMode.write);
      var fileSize = await finalFile.length();
      await file.write(finalFile.openRead().cast(), onProgress: (progress) {
        anyKindofProgressBar = progress / fileSize;
      });
      // await client.connectSFTP();
      // await client.sftpUpload(
      //   path: localPath,
      //   toPath: '/var/www/html',
      //   callback: (progress) {
      //     print('Sent $progress');
      //   },
      // );

      // for (int k = 0; k < localimages.length; k++) {
      //   String imgPath = await _createLocalImage(
      //       localimages[k], "assets/icons/${localimages[k]}");
      //   await client.sftpUpload(path: imgPath, toPath: '/var/www/html');
      // }
      await client.execute(
          'echo "http://lg1:81/$projectname.kml" > /var/www/html/kmls.txt');

      return await client.execute(
          'echo "flytoview=${flyto.generateLinearString()}" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  buildOrbit(String content) async {
    dynamic credencials = await _getCredentials();

    String localPath = await _localPath;
    File localFile = File('$localPath/Orbit.kml');
    File finalFile = await localFile.writeAsString(content);

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );

    try {
      await client;
      final sftp = await client.sftp();
      double anyKindofProgressBar;
      final file = await sftp.open('/var/www/html/Orbit.kml',
          mode: SftpFileOpenMode.create |
          SftpFileOpenMode.truncate |
          SftpFileOpenMode.write);
      var fileSize = await finalFile.length();
      await file.write(finalFile.openRead().cast(), onProgress: (progress) {
        anyKindofProgressBar = progress / fileSize;
      });
      // await client.sftpUpload(
      //   path: filePath,
      //   toPath: '/var/www/html',
      //   callback: (progress) {
      //     print('Sent $progress');
      //   },
      // );
      return await client.execute(
          "echo '\nhttp://lg1:81/Orbit.kml' >> /var/www/html/kmls.txt");
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  startOrbit() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );

    try {
      await client;
      return await client.execute('echo "playtour=Orbit" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  stopOrbit() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );

    try {
      await client;
      return await client.execute('echo "exittour=true" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  cleanOrbit() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );

    try {
      await client;
      return await client.execute('echo "" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  Future openDemoLogos() async {
    dynamic credencials = await _getCredentials();

    SSHClient client = SSHClient(
      await SSHSocket.connect('${credencials['ip']}', int.parse('${credencials['port']}')),
      // host: '${credencials['ip']}',
      // port: int.parse('${credencials['port']}'),
      username: '${credencials['username']}',
      onPasswordRequest: () => '${credencials['pass']}',
    );
    int rigs = 4;
    rigs = (int.parse(credencials['numberofrigs']) / 2).floor() + 2;
    String openLogoKML = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
	<name>VolTrac</name>
	<open>1</open>
	<description>The logo it located in the bottom left hand corner</description>
	<Folder>
		<name>tags</name>
		<Style>
			<ListStyle>
				<listItemType>checkHideChildren</listItemType>
				<bgColor>00ffffff</bgColor>
				<maxSnippetLines>2</maxSnippetLines>
			</ListStyle>
		</Style>
		<ScreenOverlay id="abc">
			<name>VolTrac</name>
			<Icon>
				<href>https://raw.githubusercontent.com/SagittariusA11/kml-images_RLA_LiquidGalaxy_GSoC-23/main/all_logos.png</href>
			</Icon>
			<overlayXY x="0" y="1" xunits="fraction" yunits="fraction"/>
			<screenXY x="0.05" y="0.95" xunits="fraction" yunits="fraction"/>
			<rotationXY x="0" y="0" xunits="fraction" yunits="fraction"/>
			<size x="0.6" y="0" xunits="fraction" yunits="fraction"/>
		</ScreenOverlay>
	</Folder>
</Document>
</kml>
  ''';
    try {
      await client;
      await client
          .execute("echo '$openLogoKML' > /var/www/html/kml/slave_$rigs.kml");
    } catch (e) {
      return Future.error(e);
    }
  }
}

