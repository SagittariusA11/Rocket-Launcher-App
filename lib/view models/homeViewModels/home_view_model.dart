import 'package:get/get.dart';

import '../../animation/home_view_animation.dart';

HomeViewModel homeViewModel = HomeViewModel();
final homeViewController = Get.put(homeViewModel);

class HomeViewModel extends GetxController{

  RxInt _selectedView = 0.obs;

  int get selectedView => _selectedView.value;

  changeSelectedView(int value){
    _selectedView.value = value;
    drawerAnimationController.reverse();
  }
}