import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/auth/Driverforgetpassword/verifycodeforgetpassword.dart';
import '../../../../core/constant/colors.dart';

class DriverVerifycodeForgetPassword extends StatelessWidget {
  const DriverVerifycodeForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    DriverVerifycodeForgetPasswordrControllerImp controller =
    Get.put(DriverVerifycodeForgetPasswordrControllerImp());
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.darkbluecolor,
        title: const Text(
          "ادخل رقم التحقق",
          style: TextStyle(color: Colors.white, fontFamily: "Tejwal"),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(25.sp),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          const Center(
            child: Column(
              children: [
                Text(
                  "لإعادة تعيين كلمة المرور يجب ادخال الرمز المرسل إليك",
                  style: TextStyle(
                    color: AppColors.darkbluecolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: "Tejwal",
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "وصلتك رسالة بالرمز",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontFamily: "Tejwal",
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 25.sp),

          // إدخال الرمز
          OtpTextField(
            borderRadius: BorderRadius.circular(15),
            numberOfFields: 6,
            borderColor: const Color(0xFF512DA8),
            showFieldAsBox: true,
            onCodeChanged: (String code) {},
            onSubmit: (String verificationCode) {
              // نخزن الكود في الـ controller
              controller.verifyCode = verificationCode;
            },
          ),

          SizedBox(height: 30.sp),

          // زر التالي
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkbluecolor,
              padding: EdgeInsets.symmetric(vertical: 15.sp),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (controller.verifyCode != null &&
                  controller.verifyCode!.length == 6) {
                controller.gotoresetpassword();
              } else {
                Get.snackbar("خطأ", "يرجى إدخال كود مكون من 6 أرقام",
                    backgroundColor: Colors.red.shade200,
                    colorText: Colors.white);
              }
            },
            child: const Text(
              "التالي",
              style: TextStyle(
                  fontFamily: "Tejwal", fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
