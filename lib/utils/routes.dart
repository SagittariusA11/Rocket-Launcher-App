import 'package:flutter/material.dart';
import 'package:rocket_launcher_app/utils/routeNames.dart';


import '../views/connectionManager.dart';
import '../views/errorView.dart';
import '../views/help.dart';
import '../views/homeView/home.dart';
import '../views/homeView/tab.dart';
import '../views/homeView/launchInfo.dart';
import '../views/homeView/launchList.dart';
import '../views/inventory.dart';
import '../views/homeView/launchMap.dart';
import '../views/lgActions.dart';
import '../views/onBoarding.dart';
import '../views/settings.dart';
import '../views/splash.dart';
import '../views/ytLive.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name){

    //Splash
      case RouteNames.splash:
        return MaterialPageRoute(builder:
            (BuildContext context) => const Splash()
        );

    //ErrorView
      case RouteNames.errorView:
        return MaterialPageRoute(builder:
            (BuildContext context)=>ErrorView()
        );

    //Help
      case RouteNames.help:
        return MaterialPageRoute(builder:
            (BuildContext context)=>HelpView()
        );

    //Connection Manager
      case RouteNames.connectionManager:
        return MaterialPageRoute(builder:
            (BuildContext context)=>ConnectionManagerView()
        );

      case RouteNames.inventory:
        return MaterialPageRoute(builder:
            (BuildContext context)=>InventoryView()
        );

      case RouteNames.tabView:
        return MaterialPageRoute(builder:
            (BuildContext context)=>TabView()
        );

      case RouteNames.homeView:
        return MaterialPageRoute(builder:
            (BuildContext context)=>homeView()
        );

      case RouteNames.lgActions:
        return MaterialPageRoute(builder:
            (BuildContext context)=>LGActionsView()
        );

      case RouteNames.onBoarding:
        return MaterialPageRoute(builder:
            (BuildContext context)=>OnBoarding()
        );

      case RouteNames.settings:
        return MaterialPageRoute(builder:
            (BuildContext context)=>SettingsView()
        );


    //Invalid Route Exception
      default:
        return MaterialPageRoute(builder:
            (BuildContext context)=>ErrorView()
        );
    }
  }
}