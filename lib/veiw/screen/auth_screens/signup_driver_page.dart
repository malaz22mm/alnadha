import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:alnadha/core/classes/stutusconntection.dart';
import 'package:alnadha/core/constant/colors.dart';
import 'package:alnadha/veiw/widget/auth_widget/custom_curve_clipper.dart';

import '../../../controller/driver_signup_controller.dart';
import '../../../core/classes/handlingrequstveiw.dart';
import '../../../core/functions/validetor.dart';
import '../../widget/auth_widget/custom_elevetedButton_auth.dart';
import '../../widget/auth_widget/custom_textform_auth.dart';

class DriverSignupPage extends StatelessWidget {
  const DriverSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DriverSignupController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: GetBuilder<DriverSignupController>(
            builder: (controller) => Column(
              children: [
                const CustomCurveClipper(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        "Register as Driver",
                        style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primarycolor),
                      ),
                      SizedBox(height: 10.h),

                      // Full Name
                      CustomTextFormAuth(
                        hinttext: "User Name",
                        mycontroller: controller.username,
                        valid: (val) {
                          return validInput("username", 3, 30, val!);
                        },
                        isNumber: false,
                        icons: const Icon(Icons.person),
                      ),

                      SizedBox(height: 10.h),

                      // Email
                      CustomTextFormAuth(
                        hinttext: "Email",
                        mycontroller: controller.email,
                        valid: (val) {
                          return validInput("email", 10, 50, val!);
                        },
                        isNumber: false,
                        icons: const Icon(Icons.email),
                      ),

                      SizedBox(height: 10.h),

                      // Phone
                      CustomTextFormAuth(
                        hinttext: "Phone",
                        mycontroller: controller.phone,
                        valid: (val) {
                          return validInput("phone", 8, 15, val!);
                        },
                        isNumber: true,
                        icons: const Icon(Icons.phone),
                      ),

                      SizedBox(height: 10.h),
// نوع السيارة
                      DropdownButtonFormField<String>(
                        value: controller.type.text.isNotEmpty ? controller.type.text : null,
                        decoration: InputDecoration(
                          hintText: "Car Type",
                          prefixIcon: const Icon(Icons.directions_car),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: "car", child: Text("Car")),
                          DropdownMenuItem(value: "truck", child: Text("Truck")),
                          DropdownMenuItem(value: "motorcycle", child: Text("Motorcycle")),
                          DropdownMenuItem(value: "bicycle", child: Text("Bicycle")),
                        ],
                        onChanged: (value) {
                          controller.type.text = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a vehicle type";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      // رقم السيارة
                      CustomTextFormAuth(
                        hinttext: "Vehicle Number",
                        mycontroller: controller.vehicleNumber,
                        valid: (val) {
                          return validInput("vehicle_number", 2, 20, val!);
                        },
                        isNumber: false,
                        icons: const Icon(Icons.confirmation_number),
                      ),

                      SizedBox(height: 10.h),

                      // Password
                      CustomTextFormAuth(
                        hinttext: "Password",
                        mycontroller: controller.password,
                        valid: (val) {
                          return validInput("password", 6, 30, val!);
                        },
                        isNumber: false,
                        obscureText: controller.showPass,
                        icons: const Icon(Icons.lock),
                        onTapIcon: controller.showPassword,
                        iconData: controller.showPass
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),

                      SizedBox(height: 10.h),

                      // Confirm Password
                      CustomTextFormAuth(
                        hinttext: "Confirm Password",
                        mycontroller: controller.conpass,
                        valid: (val) {
                          return validInput("password", 6, 30, val!);
                        },
                        isNumber: false,
                        obscureText: controller.showPass,
                        icons: const Icon(Icons.lock),
                        onTapIcon: controller.showPassword,
                        iconData: controller.showPass
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                controller.statusRequest == StatusRequest.failure
                    ? CustomButtonAuth(
                  title: "Sign up",
                  onpressed: () {
                    controller.signUp();
                  },
                )
                    : HandlingDataView(
                  widget: CustomButtonAuth(
                    title: "Sign up",
                    onpressed: () {
                      controller.signUp();
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
