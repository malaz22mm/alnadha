import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/auth/forgetpassword/resetpassword.dart';
import '../../../../core/classes/handlingrequstveiw.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/functions/validetor.dart';
import '../../../widget/auth_widget/custom_textform_auth.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordControllerImp controller = ResetPasswordControllerImp();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.darkbluecolor,
        title:const Text(
          "إعادة تعيين كلمة السر",
          style: TextStyle(color: Colors.white, fontFamily: "Tejwal"),
        ),
      ),
      body:GetBuilder<ResetPasswordControllerImp>(
        builder: (controller){
          return HandlingDataRequest(statusRequest: controller.statusRequest, widget:  ListView(
            padding: EdgeInsets.all(25.sp),
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              const Center(
                child: Column(
                  children: [
                    Text(
                      "أدخل كلمة السر الجديدة",
                      style: TextStyle(
                          color: AppColors.darkbluecolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: "Tejwal"),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.sp,
              ),
              CustomTextFormAuth(
                  icons: Icon(Icons.person),
                  hinttext: "ادخل كلمة المرور الجديدة",
                  mycontroller: controller.newpassword,
                  valid: (val) {
                    validInput("email", 5, 25, val!);
                  },
                  isNumber: false)
            ],
          ));
        },
      )
    );
  }
}
