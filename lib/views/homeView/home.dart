

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rocket_launcher_app/views/connectionManager.dart';

import '../../animation/home_view_animation.dart';
import '../../config/appTheme.dart';
import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../utils/utils.dart';
import '../../view models/home_view_model.dart';
import '../aboutUs.dart';
import '../help.dart';
import '../inventory.dart';
import '../lgActions.dart';
import '../settings.dart';
import '../takeATour.dart';
import 'launch.dart';

class homeView extends StatefulWidget {
  const homeView({Key? key}) : super(key: key);

  @override
  State<homeView> createState() => _homeViewState();
}

class _homeViewState extends State<homeView> with SingleTickerProviderStateMixin{

  HomeViewAnimation homeViewAnimation = HomeViewAnimation();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ScreenConfig.init(context);
  }

  @override
  void initState() {
    super.initState();
    homeViewAnimation.initiateHomeAnimation(this);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
      LaunchView(),
      AboutUsView(),
      HelpView(),
      LGActionsView(),
      ConnectionManagerView(),
      SettingsView(),
      TakeATourView(),
      InventoryView(),
    ];

    return AnimatedBuilder(
        animation: drawerAnimationController,
        child: Menu(),
        builder: (context,child){
          return Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.blue.withOpacity(opacityAnimation.value),
                actions: [
                  IconButton(
                    onPressed: _onDrawerTapped,
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      color: Color.fromARGB(255, 36, 83, 248),
                      size: 33,
                      progress: drawerAnimationController.view,
                    ),
                  ),
                ]
            ),

            body: Stack(
                children: [
                  //We have Our View Pages Here :
                  Obx(() => Opacity(
                      opacity: opacityAnimation.value,
                      child: GestureDetector(
                          onTap: (){
                            if(drawerAnimationController.isCompleted) {
                              drawerAnimationController.reverse();
                            }
                          },
                          child: views[homeViewController.selectedView]
                      )
                  ),
                  ),


                  //This is the CustomDrawer :
                  Positioned(
                      right: drawerAnimation.value,
                      top: ScreenConfig.heightPercent*2.5,
                      child: Opacity(
                        opacity: drawerAnimationController.value,
                        child: child,
                      )
                  )
                ]
            ),
          );
        }
    );
  }

  void _onDrawerTapped(){
    if(drawerAnimationController.isCompleted){
      drawerAnimationController.reverse();
    }else{
      drawerAnimationController.forward();
    }
  }

  Widget Menu() {
    return Align(
      alignment: Alignment.topRight,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(60),
        child: Container(
          //height: SizeConfig.heightPercent * 50,
          width: ScreenConfig.widthPercent*35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Color.fromARGB(204, 106, 161, 244)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                .copyWith(bottom: 18),
            child: Column(
              children: [
                // const SizedBox(
                //   height: 5,
                // ),
                Row(
                  children: [
                    SizedBox(
                      width: ScreenConfig.widthPercent*1.5,
                    ),
                    Utils.images(
                        ScreenConfig.widthPercent*6.5,
                        ScreenConfig.widthPercent*6.5,
                        ImagePaths.rla_icon
                    ),
                    SizedBox(
                      width: ScreenConfig.widthPercent*1.5,
                    ),
                    const FittedBox(
                      child: Text(
                        "Rocket Launcher\nVisualiser App",
                        style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // GestureDetector(
                //   onTap: () => homeViewController.changeSelectedView(0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       SizedBox(
                //         width: 15,
                //       ),
                //       Utils.images(
                //           ScreenConfig.widthPercent*2.25,
                //           ScreenConfig.widthPercent*2.25,
                //           ImagePaths.shuttle
                //       ),
                //       SizedBox(
                //         width: 15,
                //       ),
                //       const Text(
                //         "Home",
                //         style: TextStyle(
                //             fontFamily: 'GoogleSans',
                //             fontSize: 25,
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                ListTile(
                  onTap: () => homeViewController.changeSelectedView(0),
                  title: const Text(
                    "Home",
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      ImagePaths.shuttle
                  ),
                ),
                ListTile(
                  onTap: () => homeViewController.changeSelectedView(1),
                  title: const Text(
                    "About",
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      ImagePaths.about
                  ),
                ),
                ListTile(
                  onTap: () => homeViewController.changeSelectedView(2),
                  title: const Text(
                    "Help",
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      ImagePaths.info
                  ),
                ),
                ListTile(
                  onTap: () => homeViewController.changeSelectedView(3),
                  title: const Text(
                    "Liquig Galaxy Tasks",
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      ImagePaths.tasks
                  ),
                ),
                ListTile(
                  onTap: () => homeViewController.changeSelectedView(4),
                  title: const Text(
                    "Connection Manager",
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      ImagePaths.connection
                  ),
                ),
                ListTile(
                  onTap: () => homeViewController.changeSelectedView(5),
                  title: const Text(
                    "Settings",
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      ImagePaths.settings
                  ),
                ),
                ListTile(
                  onTap: () => homeViewController.changeSelectedView(6),
                  title: const Text(
                    "Take a tour",
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      ImagePaths.tour
                  ),
                ),
                ListTile(
                  onTap: () => homeViewController.changeSelectedView(7),
                  title: const Text(
                    "Inventory",
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      ImagePaths.inventory
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  child: Container(
                    height: ScreenConfig.heightPercent*6.5,
                    width: ScreenConfig.heightPercent*26,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(ScreenConfig.heightPercent*6.5)),
                        color: const Color.fromARGB(255, 61, 92, 255)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Utils.images(
                            ScreenConfig.widthPercent*2.25,
                            ScreenConfig.widthPercent*2.25,
                            ImagePaths.logout
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Exit App",
                          style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
