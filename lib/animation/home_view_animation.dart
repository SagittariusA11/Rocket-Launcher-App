
import 'package:flutter/animation.dart';

late AnimationController drawerAnimationController;
late Animation opacityAnimation;
late Animation<double> drawerAnimation;

class HomeViewAnimation{

  void initiateHomeAnimation(obj){
    drawerAnimationController = AnimationController(
        vsync: obj, duration: const Duration(milliseconds: 500));
    drawerAnimation = Tween<double>(begin: -300, end: 20).animate(
        CurvedAnimation(
            parent: drawerAnimationController,
            curve: Curves.fastLinearToSlowEaseIn));
    opacityAnimation =
        Tween<double>(begin: 1, end: 0.2).animate(drawerAnimationController);
  }

}
