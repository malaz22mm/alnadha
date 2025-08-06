import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alnadha/controller/onbording_contoller.dart';
import '../widget/onbordring_widget/CoustomElevetedButtom.dart';
import '../widget/onbordring_widget/Coustom_Dotet.dart';
import '../widget/onbordring_widget/Coustom_Slider.dart';


class OnBordringView extends StatelessWidget {
  const OnBordringView({super.key, Key? key1});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBordingControllerImp());
    return const  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: CustomSliderOnBordring(),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomDotet(),
                    SizedBox(height: 20),
                    CustomElevetedButtomOnBording(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
