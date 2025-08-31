import 'package:get/get.dart';
import '../../../core/classes/stutusconntection.dart';
import '../../../core/constant/routing.dart';

abstract class VerifycodeForgetPasswordController extends GetxController {
  gotoresetpassword();
}

class VerifycodeForgetPasswordrControllerImp
    extends VerifycodeForgetPasswordController {
  String? verifyCode;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  gotoresetpassword() {
    Get.toNamed(
      AppRoute.resetpassword,
      arguments: {
        "code": verifyCode,
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
  }
}
