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

    try {
      final response = await forgetPasswordData.postData(email.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      update();

      if (statusRequest == StatusRequest.seccuss) {
      print("ForgetPassword response: $response");


              services.pref.setString("reset_email", email.text);
              Get.toNamed(AppRoute.driververifycodeforgetpasswors);
            } else {
              statusRequest = StatusRequest.failure;
              Get.defaultDialog(
                title: "تنبيه",
                middleText:"الإيميل غير موجود أو غير صحيح",
              );
            }

    } catch (e) {
      statusRequest = StatusRequest.serverfailure;
      print("Error in ForgetPassword: $e");
      Get.defaultDialog(
        title: "خطأ في الاتصال",
        middleText: "يرجى التحقق من الاتصال بالإنترنت أو المحاولة لاحقًا.",
      );
    }

    update();
  }
}