import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alnadha/core/constant/staticdata.dart';

import '../core/constant/routing.dart';

abstract class OnBordingController extends GetxController {
  next();
  onpagechange(int m);
}
class OnBordingControllerImp extends OnBordingController{
  int currentindex=0;
  late PageController pageController;
  @override
  next() {
    currentindex++;
    if(currentindex<StaticData().onBordingData.length){
      pageController.animateToPage(currentindex, duration:const Duration(seconds: 1), curve: Curves.easeOutBack);
    }
    else {
      Get.toNamed(AppRoute.mainloginpage);
    }
    update();
  }

  @override
  onpagechange(int index) {
    currentindex=index;
    update();
  }
  @override
  void onInit() {
    pageController=PageController();
    super.onInit();
  }
}