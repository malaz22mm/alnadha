
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:alnadha/core/constant/routing.dart';

import '../../core/classes/stutusconntection.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../data/remote/auth/driver_signup_data.dart';

class DriverSignupController extends GetxController {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController conpass;
  late TextEditingController phone;
  late TextEditingController type;
  late TextEditingController vehicleNumber;

  bool showPass = true;

  DriverSignupData signUpData = DriverSignupData(Get.find());
  MyServices services = Get.find();
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    conpass = TextEditingController();
    phone = TextEditingController();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    type = TextEditingController();
    vehicleNumber = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    conpass.dispose();
    phone.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    type.dispose();
    vehicleNumber.dispose();
    super.dispose();
  }

  showPassword() {
    showPass = !showPass;
    update();
  }

  signUp() async {
    if (conpass.text == password.text) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await signUpData.postDriverSignupData(
        email: email.text,
        password: password.text,
        username: username.text,
        conpass: conpass.text,
        phone: phone.text,
        type: type.text,
        vehicleNumber: vehicleNumber.text,
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
          middleText: "البريد الالكتروني مكرر سابقاً",
        );
        statusRequest = StatusRequest.failure;
        update();
      }
    } else {
      Get.defaultDialog(
        title: "تحذير",
        content: const Text("كلمة المرور وتأكيدها غير متطابقتين"),
      );
    }
  }
}
