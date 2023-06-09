import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../data/launches_response.dart';
import '../../utils/utils.dart';
import '../../config/appTheme.dart';
import '../../view models/homeViewModels/launchViewModel.dart';
import '../searchScreen.dart';

class LaunchView extends StatefulWidget {
  const LaunchView({Key? key}) : super(key: key);

  @override
  State<LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> with SingleTickerProviderStateMixin {

  ScrollController upcomingScrollController = ScrollController();
  ScrollController pastScrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  DateTime? selectedDate;
  DateTimeRange? selectedDateRange;

  // Future<List<UpcomingLaunch>>? _upcomingLaunchesFuture = LaunchService.fetchUpcomingLaunches();
  // Future<List<PastLaunch>>? _pastLaunchesFuture = LaunchService.fetchPastLaunches();

  Future<List<UpcomingLaunch>>? _upcomingLaunchesFuture;
  Future<List<PastLaunch>>? _pastLaunchesFuture;

  late final UpcomingLaunch upcomingLaunches;
  late final PastLaunch pastLaunches;
  bool _isDataLoaded = false;

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


  @override
  void initState() {
    setState(() {
      AppTheme().tab_color;
    });
    super.initState();
    if (!_isDataLoaded) {
      _upcomingLaunchesFuture = LaunchService.fetchUpcomingLaunches();
      _pastLaunchesFuture = LaunchService.fetchPastLaunches();
      _isDataLoaded = true;
    }
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
                          IconButton(
                            onPressed: () { print("Filter"); },
                            icon: FaIcon(
                              FontAwesomeIcons.filter,
                              color: AppTheme().ht_color.withOpacity(0.85),
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
                            icon: Icon(
                              Icons.calendar_month_rounded,
                              color: AppTheme().ht_color.withOpacity(0.85),
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
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: AppTheme().ht_color, width: 1)
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: AppTheme().ht_color,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    translate('inventory.search'),
                                    style: TextStyle(
                                        color: AppTheme().ht_color,
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
                          color: AppTheme().ht_color,
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
                          color: AppTheme().ht_color,
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
                                      color: AppTheme().ht_color,
                                    fontWeight: FontWeight.bold
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
                    width: 30,
                  ),
                  ElevatedButton(
                      onPressed: () { },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        backgroundColor: AppTheme().ebtn_color,
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
                                color: AppTheme().ht_color,
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


  Widget _buildUpcomingCard(){
    return FutureBuilder<List<UpcomingLaunch>>(
      future: _upcomingLaunchesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<UpcomingLaunch>> snapshot) {
        if (snapshot.hasData) {
          final _upcomingLaunches = snapshot.data!;
          return ScrollSnapList(
            listController: upcomingScrollController,
            itemBuilder: (BuildContext context, int index) {
              final upcominglaunch = _upcomingLaunches[index];
              return BuildUpcomingLaunchList(upcomingLaunches: upcominglaunch);
            },
            itemSize: ScreenConfig.heightPercent*30,
            dynamicItemSize: true,
            dynamicItemOpacity: 0.75,
            itemCount: _upcomingLaunches.length,
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

  Widget _buildPastCard() {
    return FutureBuilder<List<PastLaunch>>(
      future: _pastLaunchesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<PastLaunch>> snapshot) {
        if (snapshot.hasData) {
          final _pastLaunches = snapshot.data!;
          return ScrollSnapList(
            listController: pastScrollController,
            itemBuilder: (BuildContext context, int index) {
              final pastlaunch = _pastLaunches[index];
              return BuildPastLaunchList(pastLaunches: pastlaunch);
            },
            itemSize: ScreenConfig.heightPercent*25,
            dynamicItemSize: true,
            dynamicItemOpacity: 0.75,
            itemCount: _pastLaunches.length,
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

}

class BuildUpcomingLaunchList extends StatelessWidget {
  const BuildUpcomingLaunchList({Key? key, required this.upcomingLaunches}) : super(key: key);

  final UpcomingLaunch upcomingLaunches;

  @override
  Widget build(BuildContext context) {
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
            color: AppTheme().cards_color
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  upcomingLaunches.missionName,
                  // translate('launch_tab.mn'),
                  style: TextStyle(
                    fontSize: 20,
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
                    upcomingLaunches.launchDate,
                    // translate('launch_tab.date'),
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${upcomingLaunches.launchTime}    UTC",
                    // translate('launch_tab.date'),
                    style: TextStyle(
                      fontSize: 15,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    // data[0],
                    upcomingLaunches.rocketName,
                    // translate('launch_tab.rn'),
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    // data[1],
                    upcomingLaunches.launchPad,
                    // translate('launch_tab.ls'),
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

class BuildPastLaunchList extends StatelessWidget {
  const BuildPastLaunchList({Key? key, required this.pastLaunches}) : super(key: key);

  final PastLaunch pastLaunches;

  @override
  Widget build(BuildContext context) {
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
            color: AppTheme().cards_color
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  pastLaunches.missionName,
                  // translate('launch_tab.mn'),
                  style: TextStyle(
                    fontSize: 17,
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
                    pastLaunches.launchDate,
                    // translate('launch_tab.date'),
                    style: TextStyle(
                      fontSize: 15,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "${pastLaunches.launchTime}    UTC",
                    // translate('launch_tab.date'),
                    style: TextStyle(
                      fontSize: 15,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    pastLaunches.rocketName,
                    // translate('launch_tab.rn'),
                    style: TextStyle(
                      fontSize: 15,
                      color: selectedAppTheme.isLightMode?Colors.black:Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    pastLaunches.launchPad,
                    // translate('launch_tab.ls'),
                    style: TextStyle(
                      fontSize: 15,
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

