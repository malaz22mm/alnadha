import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/classes/stutusconntection.dart';
import '../core/constant/routing.dart';
import '../core/services/services.dart';
import '../data/remote/auth/driver_login_data.dart';

class DriverLoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  bool showPass = true;

  DriverLoginData loginData = DriverLoginData(Get.find());
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

    print("================ Driver Login Response $response");

    // ✅ نفحص الرد القادم من الباك مباشرة
    if (response["status"] == StatusRequest.success.name ||
        response["status"] == "Success") {
      statusRequest = StatusRequest.success;

      Map<String, dynamic> user = response['data']['user'];
      String token = response['data']['token'];

      services.pref.setString("driver_token", token);
      services.pref.setString("driver_name", user['FullName'] ?? "");
      services.pref.setString("driver_email", user['Email'] ?? "");
      services.pref.setString("driver_phone", user['Phone'] ?? "");
      services.pref.setString("driver_cartype", user['CarType'] ?? "");
      services.pref.setString("driver_carnumber", user['CarNumber'].toString());
      services.pref.setString("driver_profilepic", user['ProfilePicture'] ?? "");

      // ✅ عرض رسالة نجاح من الباك
      Get.snackbar("نجاح", response["message"] ?? "تم تسجيل الدخول بنجاح",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

      Get.offAllNamed(AppRoute.driverorder);
    } else {
      statusRequest = StatusRequest.failure;

      // ✅ عرض رسالة خطأ من الباك
      Get.snackbar("خطأ", response["message"] ?? "فشل تسجيل الدخول",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }

    update();
  }
}
