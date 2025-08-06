import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/colors.dart';
class CustomForgetPassword extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final void Function() onPressedButton;
  const CustomForgetPassword({super.key, required this.title,required this.buttonTitle, required this.onPressedButton});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
         Text(title),
        TextButton(onPressed: onPressedButton,style: TextButton.styleFrom(
            padding:  EdgeInsets.only(left: 2.w,right: 10.w)
        ), child:Text(buttonTitle,style: const TextStyle(color: AppColors.darkbluecolor,fontWeight: FontWeight.bold,fontSize: 16),),)
      ],
    );
  }
}


