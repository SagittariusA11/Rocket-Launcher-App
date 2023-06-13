import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:rocket_launcher_app/views/homeView/launch.dart';
import 'package:rocket_launcher_app/views/homeView/launchInfo.dart';
import 'package:rocket_launcher_app/views/homeView/launchMap.dart';

import '../../animation/home_view_animation.dart';
import '../../config/appTheme.dart';
import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../utils/utils.dart';

class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  LaunchView(),
                  LaunchMap(),
                  LaunchInfo()
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _tabController.index = index;
          });
        },
        backgroundColor: AppTheme().bg_color,
        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedIconTheme: IconThemeData(color: selectedAppTheme.isLightMode?Colors.grey.shade300:Colors.grey,),
        unselectedItemColor: selectedAppTheme.isLightMode?Colors.grey.shade300:Colors.grey,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch),
            label: 'Launch'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Launch Info'
          ),
        ],
      ),
    );
  }
}
