import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../core/constant/routing.dart';
import '../core/services/services.dart';

class SplashController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void onInit() {
    initAnimations();
    goToHomeView();
    super.onInit();
  }

  void initAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    animationController.forward();
  }

  void goToHomeView() {
    Future.delayed(const Duration(seconds: 3), () async{
      // final MyServices myServices = Get.find();
      // String? token = myServices.pref.getString("token");
      // String? driver_token = myServices.pref.getString('driver_token');
      // if (token != null && token.isNotEmpty) {
      //   // التوكين موجود → الصفحة الرئيسية
      //   Get.offAllNamed('/homepage');
      // }
      // else if(driver_token != null && driver_token.isNotEmpty){
      //   Get.offAllNamed(AppRoute.driverorder);
      // }
      // else {
        // لا يوجد توكين → صفحة تسجيل الدخول
        Get.toNamed(AppRoute.onbording);
      // }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}