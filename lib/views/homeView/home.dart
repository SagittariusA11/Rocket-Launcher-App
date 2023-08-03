

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rocket_launcher_app/main.dart';
import 'package:rocket_launcher_app/views/connectionManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../animation/home_view_animation.dart';
import '../../config/appTheme.dart';
import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../utils/utils.dart';
import '../../view models/homeViewModels/home_view_model.dart';
import '../aboutUs.dart';
import '../help.dart';
import '../inventory.dart';
import '../lgActions.dart';
import '../settings.dart';
import '../takeATour.dart';
import 'tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin{

  HomeViewAnimation homeViewAnimation = HomeViewAnimation();
  bool isDrawerOpen = false;

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
      TabView(),
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
                backgroundColor: selectedAppTheme.isLightMode? Colors.blue.withOpacity(opacityAnimation.value):
                selectedAppTheme.isDarkMode? Color.fromARGB(255, 7, 20, 66).withOpacity(opacityAnimation.value):
                selectedAppTheme.isRedMode? Color.fromARGB(255, 189, 37, 37).withOpacity(opacityAnimation.value):
                selectedAppTheme.isGreenMode? Color.fromARGB(255, 52, 103, 39).withOpacity(opacityAnimation.value):
                Color.fromARGB(255, 23, 72, 173).withOpacity(opacityAnimation.value),
                leading: homeViewController.selectedView == 0?Container():GestureDetector(
                  onTap: () {
                    homeViewController.changeSelectedView(0);
                    setState(() {
                      homeViewController.selectedView;
                    });
                    },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: _onDrawerTapped,
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 35,
                        progress: drawerAnimationController.view,
                      ),
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
                  ),
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
    setState(() {
      AppTheme().menu_bg_color;
      isDrawerOpen = !isDrawerOpen;
    });
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
              color: AppTheme().menu_bg_color
          ),
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
                    FittedBox(
                      child: SizedBox(
                        width: ScreenConfig.widthPercent*23,
                        child: Text(
                          translate('drawer.title'),
                          style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: Utils().fontSizeMultiplier(30),
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
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
                //             fontSize: Utils().fontSizeMultiplier(25),
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                ListTile(
                  onTap: () {
                    if(isDrawerOpen) {
                      homeViewController.changeSelectedView(0);
                      isDrawerOpen = !isDrawerOpen;
                    }
                  },
                  title: Text(
                    translate('drawer.home'),
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: Utils().fontSizeMultiplier(25),
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      selectedAppTheme.isLightMode?ImagePaths.shuttle_light:ImagePaths.shuttle_dark
                  ),
                ),
                ListTile(
                  onTap: () {
                    if(isDrawerOpen) {
                      homeViewController.changeSelectedView(1);
                      isDrawerOpen = !isDrawerOpen;
                    }
                  },
                  title: Text(
                    translate('drawer.about'),
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: Utils().fontSizeMultiplier(25),
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      selectedAppTheme.isLightMode?ImagePaths.about_light:ImagePaths.about_dark
                  ),
                ),
                ListTile(
                  onTap: () {
                    if(isDrawerOpen) {
                      homeViewController.changeSelectedView(2);
                      isDrawerOpen = !isDrawerOpen;
                    }
                  },
                  title: Text(
                    translate('drawer.help'),
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: Utils().fontSizeMultiplier(25),
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      selectedAppTheme.isLightMode?ImagePaths.info_light:ImagePaths.info_dark
                  ),
                ),
                ListTile(
                  onTap: () {
                    if(isDrawerOpen) {
                      homeViewController.changeSelectedView(3);
                      isDrawerOpen = !isDrawerOpen;
                    }
                  },
                  title: Text(
                    translate('drawer.task'),
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: Utils().fontSizeMultiplier(25),
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      selectedAppTheme.isLightMode?ImagePaths.tasks_light:ImagePaths.tasks_dark
                  ),
                ),
                ListTile(
                  onTap: () {
                    if(isDrawerOpen) {
                      homeViewController.changeSelectedView(4);
                      isDrawerOpen = !isDrawerOpen;
                    }
                  },
                  title: Text(
                    translate('drawer.connection'),
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: Utils().fontSizeMultiplier(25),
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      selectedAppTheme.isLightMode?ImagePaths.connection_light:ImagePaths.connection_dark
                  ),
                ),
                ListTile(
                  onTap: () {
                    if(isDrawerOpen) {
                      homeViewController.changeSelectedView(5);
                      isDrawerOpen = !isDrawerOpen;
                    }
                  },
                  title: Text(
                    translate('drawer.settings'),
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: Utils().fontSizeMultiplier(25),
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      selectedAppTheme.isLightMode?ImagePaths.settings_light:ImagePaths.settings_dark
                  ),
                ),
                ListTile(
                  onTap: () {
                    if(isDrawerOpen) {
                      homeViewController.changeSelectedView(6);
                      isDrawerOpen = !isDrawerOpen;
                    }
                  },
                  title: Text(
                    translate('drawer.tour'),
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: Utils().fontSizeMultiplier(25),
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      selectedAppTheme.isLightMode?ImagePaths.tour_light:ImagePaths.tour_dark
                  ),
                ),
                ListTile(
                  onTap: () {
                    if(isDrawerOpen) {
                      homeViewController.changeSelectedView(7);
                      isDrawerOpen = !isDrawerOpen;
                    }
                  },
                  title: Text(
                    translate('drawer.inventory'),
                    style: TextStyle(
                        fontFamily: 'GoogleSans',
                        fontSize: Utils().fontSizeMultiplier(25),
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  leading: Utils.images(
                      ScreenConfig.widthPercent*2,
                      ScreenConfig.widthPercent*2,
                      selectedAppTheme.isLightMode?ImagePaths.inventory_light:ImagePaths.inventory_dark
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    disconnect();
                    SystemNavigator.pop();
                  },
                  child: Container(
                    height: ScreenConfig.heightPercent*6.5,
                    width: ScreenConfig.heightPercent*26,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(ScreenConfig.heightPercent*6.5)),
                        color: selectedAppTheme.isLightMode? Color.fromARGB(255, 61, 92, 255):
                        selectedAppTheme.isDarkMode? Color.fromARGB(255, 9, 17, 47):
                        selectedAppTheme.isRedMode? Color.fromARGB(
                            255, 75, 27, 27):
                        selectedAppTheme.isGreenMode? Color.fromARGB(
                            255, 20, 42, 16):
                        Color.fromARGB(255, 12, 28, 63)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Utils.images(
                            ScreenConfig.widthPercent*2.25,
                            ScreenConfig.widthPercent*2.25,
                            selectedAppTheme.isLightMode?ImagePaths.logout_light:ImagePaths.logout_dark
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          translate('drawer.exit'),
                          style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: Utils().fontSizeMultiplier(25),
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

  disconnect() async {
    await LGConnection().cleanVisualization();
    try {
      SSHClient client = SSHClient(
        await SSHSocket.connect('', 0),
        // host: '${credencials['ip']}',
        // port: int.parse('${credencials['port']}'),
        username: '',
        onPasswordRequest: () => '',
      );
      await client;
      // open logos
      await client;
    } catch (e) {
      connectionStatus = false;
    }
  }
}

class LGConnection {
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
      return await client.execute('> /var/www/html/kmls.txt');
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