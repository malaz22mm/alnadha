import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:alnadha/core/constant/colors.dart';
import 'package:alnadha/core/constant/image.dart';
import '../../../controller/splash_controller.dart';
class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(25.sp),
        child:const Text(
          "Powered By: ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color:Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/shape.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
                color: AppColors.primarycolor,

              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/shape.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
                color: AppColors.primarycolor,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) {
                  final rotation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: controller.animationController,
                      curve: Curves.easeInOut,
                    ),
                  );

                  final scale = TweenSequence<double>([
                    TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.0), weight: 1),
                    TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 1),
                  ]).animate(
                    CurvedAnimation(
                      parent: controller.animationController,
                      curve: Curves.easeInOut,
                    ),
                  );

                  return Transform.scale(
                    scale: scale.value,
                    child: Transform.rotate(
                      angle: rotation.value * 2 * 3.1416,
                      child: Padding(
                        padding:const EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 50,
                                spreadRadius: 10,
                                offset:const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            AppImage.logo,
                            width: 300.w,
                            height: 300.w  ,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 1),
              AnimatedBuilder(
                animation: controller.slidingAnimation,
                builder: (context, _) {
                  return SlideTransition(
                    position: controller.slidingAnimation,
                    child: const Text(
                      "3L-Nadha",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color:Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),

    );
  }
}