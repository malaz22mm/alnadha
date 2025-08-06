import 'package:flutter/material.dart';
import '../../../core/constant/colors.dart';

class CustomButtonAuth extends StatelessWidget {
  final String title;
  final void Function() onpressed;

  const CustomButtonAuth({super.key, required this.title,required this.onpressed});


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
          textColor: AppColors.primarycolor,
          color: AppColors.darkbluecolor,
          onPressed: onpressed,
          child:  Text(title,style: const TextStyle(fontSize: 20),),
        ));
  }
}