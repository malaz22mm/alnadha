import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alnadha/core/constant/routing.dart';

import '../core/classes/stutusconntection.dart';
import '../core/services/services.dart';
import '../data/remote/auth/login_data.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  bool showPass = true;

  LoginData loginData = LoginData(Get.find());
  MyServices services = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  showPassword() {
    showPass = !showPass;
    update();
  }

  login() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await loginData.PostLogindata(
      email: email.text,
      password: password.text,
    );

    print("================ Login Response $response");

    // ✅ نتعامل مع الماب مباشرة
    if (response["status"] == StatusRequest.success.name ||
        response["status"] == "Success") {
      statusRequest = StatusRequest.success;

      String token = response['data']['token'];

      services.pref.setString("token", token);
      services.pref.setString("login", "1");

      // عرض رسالة نجاح من الباك
      Get.snackbar("نجاح", response["message"] ?? "تم تسجيل الدخول بنجاح",
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.offAllNamed(AppRoute.homepage, arguments: {
        'token': token,
      });
    } else {

      // عرض رسالة فشل من الباك
      Get.snackbar("خطأ", response["message"] ?? "فشل تسجيل الدخول",
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    update();
  }
}
