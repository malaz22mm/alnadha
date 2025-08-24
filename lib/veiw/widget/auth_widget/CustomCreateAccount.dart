import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/colors.dart';

class CustomCreateAccount extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final void Function() onPressedButton;

  const CustomCreateAccount({
    super.key,
    required this.title,
    required this.buttonTitle,
    required this.onPressedButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h),
        TextButton.icon(
          onPressed: onPressedButton,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            backgroundColor: Colors.green.withOpacity(0.1),
          ),
          icon: const Icon(
            Icons.person_add,
            color: Colors.green,
            size: 20,
          ),
          label: Text(
            buttonTitle,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}
