import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alnadha/core/constant/routing.dart';

import '../core/classes/stutusconntection.dart';
import '../core/services/services.dart';
import '../data/remote/auth/signup_data.dart';

class SignupController extends GetxController {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController conpass;
  late TextEditingController phone;

  bool showPass = true;
  SignupData signUpData = SignupData(Get.find());
  MyServices services = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    conpass = TextEditingController();
    phone = TextEditingController();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    conpass.dispose();
    phone.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  showPassword() {
    showPass = !showPass;
    update();
  }

  signUp() async {
    // ✅ تحقق من كلمة المرور وتأكيدها
    if (conpass.text != password.text) {
      Get.snackbar("تحذير", "كلمة المرور وتأكيدها غير متطابقين",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white);
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    var response = await signUpData.PostSignUpdata(
      email: email.text,
      password: password.text,
      username: username.text,
      conpass: conpass.text,
      phone: phone.text,
    );

    print("================ Signup Response $response");
    if (response.isNotEmpty && response['status'] == 'Success') {
      statusRequest = StatusRequest.success;

      String token = response['data']['token'];
      services.pref.setString("token", token);

      Get.snackbar("نجاح", response["message"] ?? "تم إنشاء الحساب بنجاح",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

      Get.offAllNamed(AppRoute.homepage);
    } else {
      statusRequest = StatusRequest.failure;

      Get.snackbar("خطأ", response["message"] ?? "فشل إنشاء الحساب",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }


    update();
  }
}
