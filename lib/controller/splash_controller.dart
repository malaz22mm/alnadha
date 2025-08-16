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
    Future.delayed(const Duration(seconds: 3), () async {
      final MyServices myServices = Get.find();

      String? token = myServices.pref.getString("token");
      print(token);
      String? driverToken = myServices.pref.getString("driver_token");
      print(driverToken);

      if (driverToken != null && driverToken.isNotEmpty) {
        // إذا كان السائق مسجل دخول
        Get.offAllNamed(AppRoute.driverorder);
      }
      else if (token != null && token.isNotEmpty) {
        // إذا كان المستخدم مسجل دخول
        Get.offAllNamed(AppRoute.homepage);
      }
      else {
        // لا يوجد أي جلسة → صفحة الـ Onboarding
        Get.toNamed(AppRoute.onbording);
      }
    });
  }


  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}