
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rocket_launcher_app/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/appTheme.dart';
import '../../config/imagePaths.dart';
import '../../config/screenConfig.dart';
import '../../data/inventory_response.dart';
import '../../utils/routeNames.dart';
import '../../utils/utils.dart';
import '../../view models/inventoryViewModel.dart';

class RocketsInfo extends StatefulWidget {
  const RocketsInfo({Key? key, required this.RocketID}) : super(key: key);

  final String RocketID;

  @override
  State<RocketsInfo> createState() => _RocketsInfoState();
}

class _RocketsInfoState extends State<RocketsInfo> {

  Future<RocketInfo>? _rocketInfoFuture;

  @override
  void initState() {
    super.initState();
    _rocketInfoFuture = InventoryService.fetchRocketInfo(widget.RocketID);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: FutureBuilder<RocketInfo>(
          future: _rocketInfoFuture,
          builder: (BuildContext context, AsyncSnapshot<RocketInfo> snapshot) {
            if (snapshot.hasData) {
              final _rocketInfo = snapshot.data!;
              return RocketInfoCard(rocket: _rocketInfo);
            } else if (snapshot.hasError) {
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
        ),
      ),
    );
  }
}


class RocketInfoCard extends StatelessWidget {
  const RocketInfoCard({Key? key, required this.rocket}) : super(key: key);

  final RocketInfo rocket;

  static Widget rocketAPIInfoTable(
      String text,
      double fontSize,
      TextAlign alignment
      ){
    return Container(
      height: ScreenConfig.heightPercent*5,
      width: ScreenConfig.widthPercent*11,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(width: 1.0, color: Colors.white),
          right: BorderSide(width: 1.0, color: Colors.white),
          top: BorderSide(width: 1.0, color: Colors.white),
          bottom: BorderSide(width:  1.0, color: Colors.white),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
        textAlign: alignment,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenConfig.height,
      width: ScreenConfig.width,
      color: Colors.grey.shade300.withOpacity(0.75),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: AppTheme().primary_color,
                      size: 50,
                    )
                ),
              ],
            ),
          ),
          Container(
            width: ScreenConfig.widthPercent*95,
            height: ScreenConfig.heightPercent*80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppTheme().menu_bg_color,
            ),
            child: SizedBox(
              height: ScreenConfig.heightPercent*58,
              width: ScreenConfig.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    height: ScreenConfig.heightPercent*80,
                    width: ScreenConfig.heightPercent*80*0.325,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImagePaths.rocket),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: ScreenConfig.heightPercent*80,
                      width: ScreenConfig.widthPercent*69,
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 5.0, color: Colors.white),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    FaIcon(
                                      FontAwesomeIcons.images,
                                      color: Colors.transparent,
                                      size: 35,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.globe,
                                      color: Colors.transparent,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                Text(
                                    rocket.rocketName,
                                  // translate('rocket_info.rn'),
                                  style: TextStyle(
                                      fontSize: Utils().fontSizeMultiplier(35),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ImageGrid(imgs: rocket.imgs)),
                                          );
                                          // ImageGrid(imgs: rocket.imgs,);
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.images,
                                          color: Colors.white,
                                          size: 35,
                                        )
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          launchUrl(Uri.parse(rocket.wiki));
                                          // print("Hello");
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.globe,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                              rocket.des,
                                // translate('rocket_info.des'),
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${translate('rocket_info.ff')}:   ${rocket.firstFlight}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${translate('rocket_info.h')}:   ${rocket.height} m",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${translate('rocket_info.w')}:   ${rocket.mass} kg",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${translate('rocket_info.d')}:   ${rocket.dia} m",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${translate('rocket_info.ll')}:   ${rocket.ll}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${translate('rocket_info.p_1')}:   ${rocket.p_1}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${translate('rocket_info.p_2')}:   ${rocket.p_2}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${translate('rocket_info.tw')}:   ${rocket.tw}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: ScreenConfig.widthPercent*66.32,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(width: 2.0, color: Colors.white),
                                    right: BorderSide(width: 2.0, color: Colors.white),
                                    top: BorderSide(width: 2.0, color: Colors.white),
                                    bottom: BorderSide(width:  2.0, color: Colors.white),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        rocketAPIInfoTable(
                                            "",
                                            22,
                                            TextAlign.start
                                        ),
                                        rocketAPIInfoTable(
                                            "${translate('rocket_info.fs')}:",
                                            22,
                                            TextAlign.start),
                                        rocketAPIInfoTable(
                                            "${translate('rocket_info.ss')}:",
                                            22,
                                            TextAlign.start
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        rocketAPIInfoTable(
                                            translate('rocket_info.r'),
                                            22,
                                            TextAlign.center
                                        ),
                                        rocketAPIInfoTable(
                                            rocket.fs_r,
                                            20,
                                            TextAlign.center
                                        ),
                                        rocketAPIInfoTable(
                                            rocket.ss_r,
                                            20,
                                            TextAlign.center
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        rocketAPIInfoTable(
                                            translate('rocket_info.e'),
                                            22,
                                            TextAlign.center
                                        ),
                                        rocketAPIInfoTable(
                                            rocket.fs_e,
                                            20,
                                            TextAlign.center
                                        ),
                                        rocketAPIInfoTable(
                                            rocket.ss_e,
                                            20,
                                            TextAlign.center
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        rocketAPIInfoTable(
                                            translate('rocket_info.t'),
                                            22,
                                            TextAlign.center
                                        ),
                                        rocketAPIInfoTable(
                                            "${rocket.fs_t} kN",
                                            20,
                                            TextAlign.center
                                        ),
                                        rocketAPIInfoTable(
                                            "${rocket.ss_t} kN",
                                            22,
                                            TextAlign.center
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        rocketAPIInfoTable(
                                            translate('rocket_info.f'),
                                            22,
                                            TextAlign.center
                                        ),
                                        rocketAPIInfoTable(
                                            "${rocket.fs_f} Tons",
                                            20,
                                            TextAlign.center
                                        ),
                                        rocketAPIInfoTable(
                                            "${rocket.ss_f} Tons",
                                            20,
                                            TextAlign.center
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        rocketAPIInfoTable(
                                            translate('rocket_info.bt'),
                                            22,
                                            TextAlign.center
                                        ),
                                        rocketAPIInfoTable(
                                            "${rocket.fs_bt} s",
                                            20,
                                            TextAlign.center
                                        ),
                                        rocketAPIInfoTable(
                                            "${rocket.ss_bt} s",
                                            20,
                                            TextAlign.center
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

