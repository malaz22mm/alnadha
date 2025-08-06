import 'package:get/get.dart';

import '../../../core/classes/stutusconntection.dart';
import '../../../core/constant/routing.dart';
abstract class VerifycodeForgetPasswordController extends GetxController{
  gotoresetpassword(String verifycode);
}
class VerifycodeForgetPasswordrControllerImp extends VerifycodeForgetPasswordController{
  String? userid;

  StatusRequest statusRequest=StatusRequest.none;
  @override
  gotoresetpassword( String verifycode)async{
Get.to(AppRoute.resetpassword);
  }
  @override
  void onInit() {
    //userid=Get.arguments['id'];
    super.onInit();
  }
}