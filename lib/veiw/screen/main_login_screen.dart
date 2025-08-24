import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:alnadha/veiw/screen/auth_screens/signup_page.dart';
import '../widget/auth_widget/custom_login_button.dart';
import 'auth_screens/login_driver_page.dart';
import 'auth_screens/login_page.dart';

class MainLoginScreen extends StatelessWidget {
  const MainLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding:const  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: const Text(
          "Data rights reserved to ",
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, top: 70.h, right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Welcome Back!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35.sp,
                ),
              ),
              Lottie.asset('assets/lottie/Animation - 1746181599966.json'),
              const Text(
                "What did you need?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23, color: Colors.black),
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomLoginButtom(
                title: "Log in",
                onPressed: () {
                  Get.to( const LoginPage(),
                      transition: Transition.leftToRight,
                      duration: const Duration(microseconds: 500));
                },
              ),
              CustomLoginButtom(
                title: "Sign up",
                onPressed: () {
                  Get.to(const SignupPage(),
                      transition: Transition.leftToRight,
                      duration: const Duration(microseconds: 800));
                },
              ),
            CustomLoginButtom(title: "Log in as Driver", onPressed: (){
              Get.to(const LoginDriverPage(),
                  transition: Transition.leftToRight,
                  duration: const Duration(microseconds: 800));
            })
            ],
          ),
        ),
      ),
    );
  }
}
