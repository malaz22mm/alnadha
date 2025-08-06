
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:alnadha/controller/driver_login_controller.dart';
import 'package:alnadha/core/constant/colors.dart';
import 'package:alnadha/veiw/widget/auth_widget/custom_curve_clipper.dart';

import '../../../core/classes/handlingrequstveiw.dart';
import '../../../core/classes/stutusconntection.dart';
import '../../../core/functions/validetor.dart';
import '../../widget/auth_widget/custom_elevetedButton_auth.dart';
import '../../widget/auth_widget/custom_textform_auth.dart';
import '../../widget/auth_widget/forgetpassword_button.dart';

class LoginDriverPage extends StatelessWidget {
  const LoginDriverPage({super.key});

  @override
  Widget build(BuildContext context) {
    DriverLoginController controller = Get.put(DriverLoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: GetBuilder<DriverLoginController>(
            builder: (controller) => Column(
              children: [
                const CustomCurveClipper(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        "Welcome Driver!",
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primarycolor,
                        ),
                      ),
                      CustomTextFormAuth(
                        hinttext: "Email",
                        mycontroller: controller.email,
                        valid: (val) {
                          validInput("email", 10, 10, val!);
                          return null;
                        },
                        isNumber: false,
                        icons: const Icon(Icons.person),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      CustomTextFormAuth(
                        hinttext: "Password",
                        mycontroller: controller.password,
                        valid: (val) {
                          validInput("password", 10, 10, val!);
                          return null;
                        },
                        isNumber: false,
                        obscureText: controller.showPass,
                        icons: const Icon(Icons.password),
                        onTapIcon: () {
                          controller.showPassword();
                        },
                        iconData: controller.showPass ? Icons.visibility : Icons.visibility_off,
                      ),
                    ],
                  ),
                ),
                CustomForgetPassword(
                  title: "Driver don't have Account?",
                  onPressedButton: () {
                    Get.toNamed("/driversignup");
                  },
                  buttonTitle: "Sign Up",
                ),
                CustomForgetPassword(
                  title: "Driver forgot password?",
                  onPressedButton: () {},
                  buttonTitle: "Reset Password",
                ),
                controller.statusRequest == StatusRequest.failure
                    ? CustomButtonAuth(
                  title: "Login as Driver",
                  onpressed: () {
                    controller.login();
                  },
                )
                    : HandlingDataView(
                  widget: CustomButtonAuth(
                    title: "Login as Driver",
                    onpressed: () {
                      controller.login();
                    },
                  ),
                  statusRequest: controller.statusRequest,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
