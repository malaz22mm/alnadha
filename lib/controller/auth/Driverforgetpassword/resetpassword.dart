import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/classes/stutusconntection.dart';
import '../../../core/constant/routing.dart';
import '../../../core/services/services.dart';
import '../../../data/remote/driverforget/resetpassworddata.dart';

abstract class DriverResetPassword extends GetxController {
  ResetEndPassword();
  checkInitialData();
}

class DriverResetPasswordControllerImp extends DriverResetPassword {
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  String? code;
  String? email;
  StatusRequest statusRequest = StatusRequest.none;

  DriverResetPasswordData resetPasswordData = DriverResetPasswordData(Get.find());
  MyServices myServices = Get.find();

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  void initializeData() {
    final args = Get.arguments;
    code = args?['code'];
    email = myServices.pref.getString("reset_email");
  }

  @override
  void onReady() {
    super.onReady();
    checkInitialData();
  }

  @override
  checkInitialData() {
    if (code == null || email == null) {
      Get.snackbar("خطأ", "البيانات غير مكتملة");
      Future.delayed(Duration.zero, () {
        Get.offAllNamed(AppRoute.driverforgetpassword);
      });
    }
  }

  @override
  void dispose() {
    newpassword.dispose();
    confirmpassword.dispose();
    super.dispose();
  }

  @override
  ResetEndPassword() async {
    if (newpassword.text != confirmpassword.text) {
      Get.snackbar("خطأ", "كلمتا المرور غير متطابقتين",
          backgroundColor: Colors.red.shade200, colorText: Colors.white);
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await resetPasswordData.postData(
        email!,
        newpassword.text,
        confirmpassword.text,
        code!,
      );

      if (response is Map && response['status'] == "Success") {
        Get.snackbar("نجاح", "تمت إعادة تعيين كلمة المرور بنجاح",
            backgroundColor: Colors.green.shade300, colorText: Colors.white);
        Get.offAllNamed(AppRoute.driverloginpage);
      } else {
        Get.snackbar("خطأ", response['message'] ?? "حدث خطأ",
            backgroundColor: Colors.red.shade200, colorText: Colors.white);
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالخادم",
          backgroundColor: Colors.red.shade200, colorText: Colors.white);
      statusRequest = StatusRequest.failure;
    }

    update();
  }
}