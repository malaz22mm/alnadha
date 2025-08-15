import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:alnadha/core/constant/routing.dart';

import '../core/classes/stutusconntection.dart';
import '../core/functions/handingdatacontroller.dart';
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
    if(conpass.text==password.text){
      statusRequest = StatusRequest.loading;
      update();
      var response = await signUpData.PostSignUpdata(email: email.text,
          password: password.text,
          username: username.text,
          conpass: conpass.text,
          phone: phone.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      update();
      print(statusRequest);
      if (statusRequest == StatusRequest.seccuss) {

        String token = response['data']['token'];

        services.pref.setString("token", token);

        Get.toNamed(AppRoute.homepage);

      }
      if (response == StatusRequest.serverfailure) {
        Get.defaultDialog(
            title: "تحذير", middleText: "البريد الالكتروني مكرر سابقاً");
        print(statusRequest);
        statusRequest = StatusRequest.failure;
        update();
      }
      update();
    }
    else {
      (
    Get.defaultDialog(
      title: "warning",
      content: const Text("password and confirm password not correct")
    )
    );
    }
    }

}