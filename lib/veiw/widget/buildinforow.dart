

import 'package:alnadha/veiw/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/colors.dart';

Widget buildInfoRow(IconData icon, String value) {
  return Padding(
    padding: EdgeInsets.all(4.w.h),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(icon, color: AppColors.black, size: 20),
          SizedBox(width: 10.w),
          CustomText(text: value),
        ],
      ),
    ),
  );
}
