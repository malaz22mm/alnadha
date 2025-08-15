import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:alnadha/core/constant/routing.dart';

import '../core/classes/stutusconntection.dart';
import '../core/functions/handingdatacontroller.dart';
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

    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    update();

    if (statusRequest == StatusRequest.seccuss) {

      String token = response['data']['token'];

      services.pref.setString("token", token);
      services.pref.setString("login", "1");
      Get.toNamed(AppRoute.homepage, arguments: {
        'token': token,
      });
    }


    if (response == StatusRequest.serverfailure) {
      Get.defaultDialog(
        title: "تحذير",
        middleText: "الحساب غير موجود",
      );
      statusRequest = StatusRequest.failure;
      update();
    }

    update();
  }


}