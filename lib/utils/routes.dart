import 'package:flutter/material.dart';
import 'package:rocket_launcher_app/utils/routeNames.dart';


import '../views/connectionManager.dart';
import '../views/errorView.dart';
import '../views/help.dart';
import '../views/inventory.dart';
import '../views/launchInfo.dart';
import '../views/launchList.dart';
import '../views/launchMap.dart';
import '../views/lgActions.dart';
import '../views/menu.dart';
import '../views/onBoarding.dart';
import '../views/rocketInfo.dart';
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
            (BuildContext context)=>Help()
        );

    //Help
      case RouteNames.connectionManager:
        return MaterialPageRoute(builder:
            (BuildContext context)=>ConnectionManager()
        );

      case RouteNames.inventory:
        return MaterialPageRoute(builder:
            (BuildContext context)=>Inventory()
        );

      case RouteNames.launchInfo:
        return MaterialPageRoute(builder:
            (BuildContext context)=>LaunchInfo()
        );

      case RouteNames.launchList:
        return MaterialPageRoute(builder:
            (BuildContext context)=>LaunchList()
        );

      case RouteNames.launchMap:
        return MaterialPageRoute(builder:
            (BuildContext context)=>LaunchMap()
        );

      case RouteNames.lgActions:
        return MaterialPageRoute(builder:
            (BuildContext context)=>LGActions()
        );

      case RouteNames.menu:
        return MaterialPageRoute(builder:
            (BuildContext context)=>Menu()
        );

      case RouteNames.onBoarding:
        return MaterialPageRoute(builder:
            (BuildContext context)=>OnBoarding()
        );

      case RouteNames.rocketInfo:
        return MaterialPageRoute(builder:
            (BuildContext context)=>RocketInfo()
        );

      case RouteNames.settings:
        return MaterialPageRoute(builder:
            (BuildContext context)=>Settings()
        );

      case RouteNames.ytLive:
        return MaterialPageRoute(builder:
            (BuildContext context)=>YTLive()
        );

    //Invalid Route Exception
      default:
        return MaterialPageRoute(builder:
            (BuildContext context)=>ErrorView()
        );
    }
  }
}