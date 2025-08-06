import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/auth/forgetpassword/verifycodeforgetpassword.dart';
import '../../../../core/constant/colors.dart';

class VerifycodeForgetPassword extends StatelessWidget {
  const VerifycodeForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    VerifycodeForgetPasswordrControllerImp controller =
        Get.put(VerifycodeForgetPasswordrControllerImp());
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.darkbluecolor,
        title:const Text(
          "ادخل رقم التحقق",
          style: TextStyle(color: Colors.white, fontFamily: "Tejwal"),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(25.sp),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          const Center(
            child: Column(
              children: [
                Text(
                  "لإعادة تعيين كلمة المرور يجب ادخال الرمز المرسل إليك",
                  style: TextStyle(
                      color: AppColors.darkbluecolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: "Tejwal"),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "وصلتك رسالة بالرمز",
                  style: TextStyle(color: Colors.grey, fontSize: 18,fontFamily: "Tejwal"),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25.sp,
          ),
          OtpTextField(
            borderRadius: BorderRadius.circular(15),
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            showFieldAsBox: true,
            onCodeChanged: (String code) {},
            onSubmit: (String verificationCode) {
              controller.gotoresetpassword(verificationCode);

            }, // end onSubmit
          ),
        ],
      ),
    );
  }
}
