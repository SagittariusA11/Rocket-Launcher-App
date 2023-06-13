import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../config/imagePaths.dart';
import '../config/screenConfig.dart';
import '../utils/utils.dart';
import '../view models/splashModel.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  SplashModel splashModel = SplashModel();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ScreenConfig.init(context);
  }

  @override
  void initState() {
    super.initState();
    splashModel.initiateApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Utils.images(
                  ScreenConfig.heightPercent*25,
                  ScreenConfig.heightPercent*25,
                  ImagePaths.rla_icon
              ),
              SizedBox(
                height: ScreenConfig.heightPercent*5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Utils.images(
                      ScreenConfig.heightPercent*20,
                      ScreenConfig.heightPercent*20*1.284,
                      ImagePaths.lg_logo
                  ),
                  SizedBox(
                    width: ScreenConfig.heightPercent*5,
                  ),
                  Utils.images(
                      ScreenConfig.heightPercent*20,
                      ScreenConfig.heightPercent*20*1.682,
                      ImagePaths.gsoc_logo
                  ),
                  SizedBox(
                    width: ScreenConfig.heightPercent*5,
                  ),
                  Utils.images(
                      ScreenConfig.heightPercent*10,
                      ScreenConfig.heightPercent*10*3.8778,
                      ImagePaths.lgeu_logo
                  ),
                ],
              ),
              SizedBox(
                height: ScreenConfig.heightPercent*5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Utils.images(
                      ScreenConfig.heightPercent*10,
                      ScreenConfig.heightPercent*10*2.0495,
                      ImagePaths.lglab_logo
                  ),
                  SizedBox(
                    width: ScreenConfig.heightPercent*5,
                  ),
                  Utils.images(
                      ScreenConfig.heightPercent*10,
                      ScreenConfig.heightPercent*10*1.7803,
                      ImagePaths.gdg_logo
                  ),
                  SizedBox(
                    width: ScreenConfig.heightPercent*5,
                  ),
                  Utils.images(
                      ScreenConfig.heightPercent*10,
                      ScreenConfig.heightPercent*10*3.2258,
                      ImagePaths.wtm_logo
                  ),
                  SizedBox(
                    width: ScreenConfig.heightPercent*5,
                  ),
                  Utils.images(
                      ScreenConfig.heightPercent*10,
                      ScreenConfig.heightPercent*10*1.44,
                      ImagePaths.ticlab_logo
                  ),
                  SizedBox(
                    width: ScreenConfig.heightPercent*5,
                  ),
                  Utils.images(
                      ScreenConfig.heightPercent*10,
                      ScreenConfig.heightPercent*10*2.6786,
                      ImagePaths.pal_logo
                  ),
                ],
              ),
              SizedBox(
                height: ScreenConfig.heightPercent*5,
              ),
              Container(
                height: ScreenConfig.heightPercent*10,
                width: ScreenConfig.widthPercent*80,
                child: FittedBox(
                  child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          translate('title.name'),
                          textStyle: TextStyle(
                              fontFamily: 'GoogleSans',
                              fontSize: Utils().fontSizeMultiplier(55),
                              color: Color.fromARGB(255, 204, 204, 204),
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
