import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/classes/stutusconntection.dart';
import '../../../core/constant/routing.dart';
import '../../../core/services/services.dart';
abstract class ForgetPasswordController extends GetxController{
  ForgetPassword();
}
class ForgetPasswordControllerImp extends ForgetPasswordController{
  late TextEditingController email;
  String?id;
  MyServices services=Get.find();
  StatusRequest statusRequest=StatusRequest.none;
  @override
  ForgetPassword() async{
  Get.toNamed(AppRoute.verifycodeforgetpasswors);
    }

  @override
  void onInit() {
  email=TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}