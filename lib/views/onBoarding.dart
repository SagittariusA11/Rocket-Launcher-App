import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:rocket_launcher_app/config/imagePaths.dart';
import 'package:rocket_launcher_app/config/screenConfig.dart';

import '../utils/routeNames.dart';
import '../utils/utils.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 41, 111, 215),
                Colors.white,
              ],
              begin: Alignment(1.20, 1.20),
              end: Alignment(-0.5, -0.5),
              stops: [0.5, 0.5],
              transform: GradientRotation(2.35),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: ScreenConfig.widthPercent*25,
                height: ScreenConfig.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(
                    //   height: ScreenConfig.heightPercent*10,
                    // ),
                    SizedBox(
                      height: ScreenConfig.heightPercent*22,
                      child: FittedBox(
                        child: Text(
                          translate('on_board.app'),
                          style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 55,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: ScreenConfig.heightPercent*10,
                    // ),
                    Utils.images(
                      ScreenConfig.heightPercent*57,
                      ScreenConfig.heightPercent*57*0.6705,
                      ImagePaths.fleet_of_rockets,
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenConfig.widthPercent*70,
                height: ScreenConfig.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text(
                                translate('on_board.title'),
                                style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    fontSize: 50,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenConfig.widthPercent*5,
                            ),
                            Utils.images(
                                ScreenConfig.heightPercent*18,
                                ScreenConfig.heightPercent*18,
                                ImagePaths.rla_icon
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FittedBox(
                              child: Text(
                                translate('on_board.h1'),
                                style: TextStyle(
                                    fontFamily: 'GoogleSans',
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenConfig.widthPercent*13,
                            )
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: ScreenConfig.heightPercent*2.5,
                    // ),
                    Container(
                      height: ScreenConfig.heightPercent*35,
                      width: ScreenConfig.heightPercent*35*2.3906,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImagePaths.lg_demo)
                          ),
                        borderRadius: BorderRadius.circular(ScreenConfig.heightPercent*7.5),
                      ),
                    ),
                    // SizedBox(
                    //   height: ScreenConfig.heightPercent*1.5,
                    // ),
                    FittedBox(
                      child: Text(
                        translate('on_board.h2'),
                        style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {Navigator.of(context).pushNamed(RouteNames.homeView);},
                          child: Container(
                            height: ScreenConfig.heightPercent*10,
                            width: ScreenConfig.heightPercent*10*1.58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(ScreenConfig.heightPercent*10),
                                bottomLeft: Radius.circular(ScreenConfig.heightPercent*7),
                                bottomRight: Radius.circular(ScreenConfig.heightPercent*7),
                              ),
                              color: const Color.fromARGB(255, 51, 84, 202)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: ScreenConfig.heightPercent*5,
                                  width: ScreenConfig.heightPercent*5,
                                  child: Image.asset(ImagePaths.right_arrow)
                                ),
                                SizedBox(
                                  width: ScreenConfig.heightPercent*10*1.58*0.2,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*5,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
