import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/onbording_contoller.dart';
import '../../../core/constant/staticdata.dart';




class CustomDotet extends StatelessWidget{
  const CustomDotet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBordingControllerImp>(builder: (controller){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          ...List.generate(
            StaticData().onBordingData.length,
                (index) => AnimatedContainer(
              margin: const EdgeInsets.only(right: 6),
              duration:const  Duration(milliseconds: 500),
              width: controller.currentindex==index?16.0:8.0,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          )
        ],
      );
    });
  }
}
