
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/classes/stutusconntection.dart';
import '../core/constant/routing.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/services/services.dart';
import '../data/remote/auth/driver_login_data.dart';

class DriverLoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  bool showPass = true;

  DriverLoginData loginData = DriverLoginData(Get.find()) ;
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

    print("=============================== Driver Controller $response");
    statusRequest = handlingData(response);
    update();

    if (statusRequest == StatusRequest.seccuss) {
      Map<String, dynamic> data = response['data'];
      Map<String, dynamic> user = data['user'];
      String token = data['token'];

      services.pref.setString("driver_token", token);
      services.pref.setString("driver_name", user['FullName'] ?? "");
      services.pref.setString("driver_email", user['Email'] ?? "");
      services.pref.setString("driver_phone", user['Phone'] ?? "");
      services.pref.setString("driver_cartype", user['CarType'] ?? "");
      services.pref.setString("driver_carnumber", user['CarNumber'].toString());
      services.pref.setString("driver_profilepic", user['ProfilePicture'] ?? "");

      Get.toNamed(AppRoute.driverorder);


  } else if (response == StatusRequest.serverfailure) {
      Get.defaultDialog(
        title: "تحذير",
        middleText: "حدث خطأ في تسجيل الدخول كسفير",
      );
      statusRequest = StatusRequest.failure;
      update();
    }
  }
}
