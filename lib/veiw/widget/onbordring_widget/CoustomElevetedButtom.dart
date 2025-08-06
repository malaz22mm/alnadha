import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:alnadha/core/constant/colors.dart';

import '../../../controller/onbording_contoller.dart';

class CustomElevetedButtomOnBording extends GetView<OnBordingControllerImp> {
  const CustomElevetedButtomOnBording({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
          textColor: Colors.white,
          color: AppColors.primarycolor,
          onPressed: () {
            controller.next();
          },
          child:  Text("next",style: TextStyle(color: AppColors.darkbluecolor,fontSize: 19.sp,fontWeight: FontWeight.bold),),
        ));
  }
}
