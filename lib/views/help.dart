import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../config/imagePaths.dart';
import '../config/screenConfig.dart';
import '../utils/utils.dart';

class HelpView extends StatefulWidget {
  const HelpView({Key? key}) : super(key: key);

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenConfig.width,
        height: ScreenConfig.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImagePaths.help_bg),
                fit: BoxFit.cover
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, bottom: 20),
                child: Row(
                  children: [
                    Utils.images(
                        ScreenConfig.heightPercent*10,
                        ScreenConfig.heightPercent*10,
                        ImagePaths.rla_icon
                    ),
                    SizedBox(
                      width: ScreenConfig.widthPercent*2,
                    ),
                    Text(
                      translate('help.title'),
                      style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenConfig.widthPercent*3,
                    bottom: 20
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate('help.h1'),
                          style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*85,
                          child: Text(
                            translate('help.h1des'),
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenConfig.widthPercent*3,
                    bottom: 20
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate('help.h2'),
                          style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*80,
                          child: Text(
                            translate('help.h2des'),
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenConfig.widthPercent*3
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate('help.h3'),
                          style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: ScreenConfig.widthPercent*65,
                          child: Text(
                            translate('help.h3des'),
                            style: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
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
