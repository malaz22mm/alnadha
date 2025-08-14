import 'package:get/get.dart';
import '../../../core/classes/stutusconntection.dart';
import '../../../core/constant/routing.dart';

abstract class DriverVerifycodeForgetPasswordController extends GetxController {
  gotoresetpassword();
}

class DriverVerifycodeForgetPasswordrControllerImp
    extends DriverVerifycodeForgetPasswordController {
  String? verifyCode; // لحفظ الكود الذي أدخله المستخدم
  StatusRequest statusRequest = StatusRequest.none;

  @override
  gotoresetpassword() {
    Get.toNamed(
      AppRoute.driverresetpassword,
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
