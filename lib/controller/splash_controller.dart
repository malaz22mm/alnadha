import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../core/constant/routing.dart';

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
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed(AppRoute.onbording);
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}