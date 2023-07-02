import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:rocket_launcher_app/views/moreInfoView/rocketsInfo.dart';
import 'package:rocket_launcher_app/views/ytLive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../data/launches_response.dart';
import '../../utils/utils.dart';
import '../../config/appTheme.dart';
import '../../view models/homeViewModels/launchViewModel.dart';
import '../searchScreen.dart';

class LaunchInfo extends StatefulWidget {
  const LaunchInfo({Key? key}) : super(key: key);

  @override
  State<LaunchInfo> createState() => _LaunchInfoState();
}

class _LaunchInfoState extends State<LaunchInfo> {

  GlobalKey __LaunchInfoStateKey = GlobalKey();

  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  DateTime? selectedDate;
  DateTimeRange? selectedDateRange;
  var currentLaunch;
  bool isTapped = false;

  Future<List<AllLaunch>>? _allLaunchesFuture;
  // List<AllLaunch> _allLaunchesFuture = [];
  late final AllLaunch allLaunches;
  bool _isDataLoaded = false;
  ScrollController allScrollController = ScrollController();

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
                          IconButton(
                            onPressed: () { print("Filter"); },
                            icon: const FaIcon(
                              FontAwesomeIcons.filter,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => dateRangePickerButton(context)
                              );
                              print("Calander");
                            },
                            icon: const Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ),
                              );

                            },
                            child: Container(
                              width: ScreenConfig.widthPercent*12,
                              margin: const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.only(bottom: 5),
                              decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.white, width: 1)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    translate('inventory.search'),
                                    style: const TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
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
                    height: ScreenConfig.heightPercent*62,
                    // width: ScreenConfig.widthPercent*85,
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
                  const SizedBox(
                    width: 20,
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
                  const SizedBox(
                    width: 20,
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
          return ListView.builder(
            controller: allScrollController,
            itemBuilder: (BuildContext context, int index) {
              final alllaunch = _allLaunches[index];
              return GestureDetector(
                onTap: () {
                  currentLaunch = alllaunch;
                  isTapped = true;
                  // print("Here");
                },
                child: BuildRocketInfoItemList(allLaunches: alllaunch)
              );
            },
            itemCount: _allLaunches.length,
            scrollDirection: Axis.vertical,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: ScreenConfig.heightPercent*60,
      width: ScreenConfig.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppTheme().bg_color.withOpacity(0.5),
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
                      fontSize: Utils().fontSizeMultiplier(30),
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  height: ScreenConfig.heightPercent*35,
                  width: ScreenConfig.heightPercent*35*0.385,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImagePaths.rocket),
                        fit: BoxFit.fill
                    ),
                  ),
                ),
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
                      primary: AppTheme().bg_color,
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
                              color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                            )
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: ScreenConfig.heightPercent*56,
              width: ScreenConfig.widthPercent*30,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(width: 5.0, color: Colors.white),
                  right: BorderSide(width: 5.0, color: Colors.white),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${translate('launchInfo_tab.rn')}:   ${allLaunches.rocketName}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${translate('launchInfo_tab.date')}:   ${allLaunches.launchDate}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${translate('launchInfo_tab.time')}:   ${allLaunches.launchTime}    UTC",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${translate('launchInfo_tab.ls')}:   ${allLaunches.launchPad}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${translate('launchInfo_tab.fn')}:   ${allLaunches.flightNumber}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${translate('launchInfo_tab.py')}:   ${allLaunches.payload}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${translate('launchInfo_tab.n')}:    ${allLaunches.country}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${translate('launchInfo_tab.ct')}:    ${allLaunches.company}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  // Text(
                  //   "${translate('launchInfo_tab.orb')}:    ${allLaunches.orbit}",
                  //   style: const TextStyle(
                  //     fontSize: 22,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            launchUrl(Uri.parse(allLaunches.article));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            primary: AppTheme().bg_color,
                            shape: const StadiumBorder(),
                          ),
                          child: SizedBox(
                            width: ScreenConfig.widthPercent*6,
                            height: ScreenConfig.heightPercent*5,
                            child: Center(
                              child: Text(
                                  translate('launchInfo_tab.art'),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                  )
                              ),
                            ),
                          )
                      ),
                      ElevatedButton(
                          onPressed: () {
                            launchUrl(Uri.parse(allLaunches.wiki));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            primary: AppTheme().bg_color,
                            shape: const StadiumBorder(),
                          ),
                          child: SizedBox(
                            width: ScreenConfig.widthPercent*6,
                            height: ScreenConfig.heightPercent*5,
                            child: Center(
                              child: Text(
                                  translate('launchInfo_tab.wiki'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                  )
                              ),
                            ),
                          )
                      ),
                      ElevatedButton(
                          onPressed: () {
                            print(allLaunches.imgs);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ImageGrid(imgs: allLaunches.imgs)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            primary: AppTheme().bg_color,
                            shape: const StadiumBorder(),
                          ),
                          child: SizedBox(
                            width: ScreenConfig.widthPercent*6,
                            height: ScreenConfig.heightPercent*5,
                            child: Center(
                              child: Text(
                                  translate('launchInfo_tab.img'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                                  )
                              ),
                            ),
                          )
                      ),
                      // ElevatedButton(
                      //     onPressed: () { },
                      //     style: ElevatedButton.styleFrom(
                      //       elevation: 10,
                      //       shadowColor: Colors.grey,
                      //       primary: AppTheme().bg_color,
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
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 3.0, color: Colors.white),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${translate('launchInfo_tab.md')}:",
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          allLaunches.missionDes,
                          // translate('launchInfo_tab.md_01'),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: ScreenConfig.heightPercent*30,
                    width: ScreenConfig.widthPercent*40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${translate('launchInfo_tab.lsd')}:",
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          allLaunches.launchPadFullName,
                          // translate('launchInfo_tab.lsfn'),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          // translate(allLaunches.launchPadDes),
                          translate('launchInfo_tab.lsd_0${allLaunches.launchPadDes}'),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
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

