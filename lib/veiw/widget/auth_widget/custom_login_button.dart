import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnadha/core/constant/colors.dart';

class CustomLoginButtom extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const CustomLoginButtom({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h), // تصغير الهوامش
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkbluecolor,
          minimumSize: Size(120.w, 40.h), // حجم أصغر للزر
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20.sp, // حجم أصغر للنص
            color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
