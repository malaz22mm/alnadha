import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/setting_controller.dart';
import '../../core/constant/colors.dart';
import '../widget/custom_listtile.dart';
import '../widget/custom_text_field.dart';


class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PersonalInfoController controller = Get.put(PersonalInfoController());
    //print(controller.data!.city);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primarycolor,
          title: const Text(
            "المعلومات الشخصية",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body:GetBuilder<PersonalInfoController>(builder: (controller){
          return  Form(
            key: controller.key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CoustomListTile(
                    title: 'اسم المستخدم',
                    subtitle: "hala",
                    onTap: () {
                      controller.name.text = controller.data!.fullName!;
                      controller.defultDialog(
                          controller.data!.fullName!,
                          "تعديل اسم المستخدم",
                          CoustomTextFieldPersonal(
                              controller: controller.name,
                              isnum: false,
                              initval: controller.data!.fullName!),controller.name,'fullName');
                    },
                    iconData: Icons.person,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CoustomListTile(
                    title: 'كلمة المرور',
                    subtitle: "*****************",
                    onTap: () {
                      controller.pass.text = "**************";

                      controller.defultDialog(
                          "",
                          "تعديل كلمة المرور",
                          CoustomTextFieldPersonal(
                              controller: controller.pass,
                              isnum: false,
                              initval: "***************"),controller.pass,'user.password');
                    },
                    iconData: Icons.password,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CoustomListTile(
                    title: 'الايميل الشخصي',
                    subtitle: "hala@gmail.com",
                    onTap: () {
                      controller.email.text = controller.data!.email!;
                      controller.defultDialog(
                          controller.data!.email!,
                          "تعديل الايميل",
                          CoustomTextFieldPersonal(
                              controller: controller.email,
                              isnum: false,
                              initval: controller.data!.email!),controller.email,'email');
                    },
                    iconData: Icons.email,
                  ),

                  SizedBox(
                    height: 5.h,
                  ),
                  CoustomListTile(
                    title: 'المدينة',
                    subtitle: "homs",
                    onTap: () {
                      controller.city.text = controller.data!.city!;
                      controller.defultDialog(
                          controller.data!.city!,
                          "المدينة",
                          CoustomTextFieldPersonal(
                              controller: controller.city,
                              isnum: false,
                              initval: controller.data!.city!),controller.city,'city');
                    },
                    iconData: Icons.location_history,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CoustomListTile(
                    title: 'الجنس',
                    subtitle: "انثى",
                    onTap: () {},
                    iconData: Icons.gamepad_outlined,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CoustomListTile(
                    title: 'رقم الهاتف',
                    subtitle:"09999999",
                    onTap: () {
                      controller.phone.text = controller.data!.phoneNumber!;

                      controller.defultDialog(
                          controller.data!.phoneNumber!,
                          "تعديل رقم الهاتف",
                          CoustomTextFieldPersonal(
                              controller: controller.phone,
                              isnum: false,
                              initval: controller.data!.phoneNumber!),controller.phone,'phone_number');
                    },
                    iconData: Icons.phone,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CoustomListTile(
                    title: 'حول المستخدم',
                    subtitle: ".",
                    onTap: () {
                      controller.about.text = controller.data!.aboutMe!;
                      controller.defultDialog(
                          controller.data!.aboutMe!,
                          "تعديل وصف المستخدم",
                          CoustomTextFieldPersonal(
                              controller: controller.about,
                              isnum: false,
                              initval: controller.data!.aboutMe!),controller.about,'about_me');
                    },
                    iconData: Icons.info,
                  ),
                ],
              ),
            ),
          );
        },)
    );
  }
}