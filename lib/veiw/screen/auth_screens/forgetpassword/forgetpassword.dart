import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/auth/forgetpassword/forgetpasswordcontroller.dart';
import '../../../../core/classes/handlingrequstveiw.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/functions/validetor.dart';
import '../../../widget/auth_widget/CustomButton.dart';
import '../../../widget/auth_widget/custom_textform_auth.dart';



class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordControllerImp controllerImp =
        Get.put(ForgetPasswordControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkbluecolor,
        title:const  Text(
          "هل نسيت كلمة السر؟",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Tejwal",
          ),
        ),
        ),
      body:GetBuilder<ForgetPasswordControllerImp>(builder: (controllerImp){
        return HandlingDataRequest(statusRequest: controllerImp.statusRequest, widget:  Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                  child: Text(
                    "ادخل البريد الالكتروني",
                    style: TextStyle(
                        color: AppColors.darkbluecolor,
                        fontFamily: "Tejwal",
                        fontSize: 25),
                  )),
              CustomTextFormAuth(
               icons: Icon(Icons.email),
                hinttext: 'البريد الالكتروني',
                mycontroller: controllerImp.email,
                valid: (val) {
                  validInput("email", 3, 10, val!);
                },
                isNumber: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              CoustomButtom(title: "تأكيد", onpress:(){
                controllerImp.ForgetPassword();
              } )
            ],
          ),
        ),);
      },)
    );
  }
}
