import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'customtextfield.dart';

class AddPropertyText extends StatelessWidget {
  final String nameofitem;
  final bool isnum;
  final bool isreq;
  //final String? Function(String?) valid;
  final TextEditingController controller;
  final String? dataText;

  const AddPropertyText({
    super.key,
    required this.nameofitem,
    required this.isreq,
    required this.controller,
    required this.isnum,
    //required this.valid,
    this.dataText,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CoustomTextFieldProperty(
          hinttext: '',
          mycontroller: controller,
         //valid: valid,
          isNumber: isnum,
          width: 170.sp,
        ),
        SizedBox(
          width: 125.sp,
          child: Text(
            nameofitem,
            style: TextStyle(
              fontFamily: "Tejwal",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        isreq
            ? SizedBox(
          width: 5.sp,
          child: const Icon(
            Icons.star,
            color: Colors.yellow,
            size: 15,
          ),
        )
            : Container(width: 5.sp),
      ],
    );
  }
}