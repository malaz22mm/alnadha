import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CoustomTextSetting extends StatelessWidget {
  final String title;
  const CoustomTextSetting({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Text(
          title,
          textAlign: TextAlign.end,
          style: const TextStyle(fontFamily: "Tejwal"),
        ));

  }
}