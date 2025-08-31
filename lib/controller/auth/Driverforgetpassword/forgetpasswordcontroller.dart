import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/classes/stutusconntection.dart';
import '../../../core/constant/routing.dart';
import '../../../core/functions/handingdatacontroller.dart';
import '../../../core/services/services.dart';
import '../../../data/remote/driverforget/forgetpassworddata.dart';

class DriverForgetPasswordControllerImp extends GetxController {
  late TextEditingController email;
  StatusRequest statusRequest = StatusRequest.none;
  DriverForgetPasswordData forgetPasswordData = DriverForgetPasswordData(Get.find());
  MyServices services = Get.find();

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  Future<void> ForgetPassword() async {
    statusRequest = StatusRequest.loading;
    update();

    final result = await forgetPasswordData.postData(email.text);
    print("ForgetPassword result: $result");
    result.fold((failure) {
      // في حال خطأ
      statusRequest = failure;
      Get.defaultDialog(
        title: "تنبيه",
        middleText: "الإيميل غير موجود أو غير صحيح",
      );
    }, (response) {
      // في حال نجاح
      if (response["status"] == "Success") {
        print("ForgetPassword response: $response");
        services.pref.setString("reset_email", email.text);
        Get.toNamed(AppRoute.verifycodeforgetpasswors);
      } else {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
          title: "تنبيه",
          middleText: "الإيميل غير موجود أو غير صحيح",
        );
      }
    });

    update();
  }
}