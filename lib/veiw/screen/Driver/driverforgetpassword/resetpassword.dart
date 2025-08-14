import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controller/auth/Driverforgetpassword/resetpassword.dart';
import '../../../../core/classes/handlingrequstveiw.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/functions/validetor.dart';
import '../../../widget/auth_widget/custom_textform_auth.dart';

class DriverResetPasswordScreen extends StatelessWidget {
  const DriverResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverResetPasswordControllerImp());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.darkbluecolor,
        title: const Text(
          "إعادة تعيين كلمة السر",
          style: TextStyle(color: Colors.white, fontFamily: "Tejwal"),
        ),
      ),
      body: GetBuilder<DriverResetPasswordControllerImp>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: ListView(
              padding: EdgeInsets.all(25.sp),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                const Center(
                  child: Column(
                    children: [
                      Text(
                        "أدخل كلمة السر الجديدة",
                        style: TextStyle(
                          color: AppColors.darkbluecolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: "Tejwal",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.sp),
                CustomTextFormAuth(
                  icons: const Icon(Icons.lock),
                  hinttext: "ادخل كلمة المرور الجديدة",
                  mycontroller: controller.newpassword,
                  valid: (val) {
                    return validInput("password", 5, 25, val!);
                  },
                  isNumber: false,
                ),
                SizedBox(height: 15.sp),
                CustomTextFormAuth(
                  icons: const Icon(Icons.lock_outline),
                  hinttext: "أعد إدخال كلمة المرور",
                  mycontroller: controller.confirmpassword,
                  valid: (val) {
                    return validInput("password", 5, 25, val!);
                  },
                  isNumber: false,
                ),
                SizedBox(height: 20.sp),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkbluecolor,
                    padding: EdgeInsets.symmetric(vertical: 15.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    controller.ResetEndPassword();
                  },
                  child: const Text(
                    "تأكيد",
                    style: TextStyle(
                      fontFamily: "Tejwal",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}