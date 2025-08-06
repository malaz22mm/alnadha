import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnadha/core/constant/colors.dart';
import 'package:alnadha/core/constant/image.dart';

class CustomCurveClipper extends StatelessWidget {
  const CustomCurveClipper({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomCurveClipper(),
      child: Container(
        height: 350.h,
        color: AppColors.primarycolor,
        child:  Center(child: Column(
          children: [
             SizedBox(height: 50.h,),
           // const Text("AL NADHA",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            SizedBox(height: 10.h,),
            Image.asset(AppImage.logo1,width: 200.w,),
          ],
        )),
        ),
      );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(1, size.height - size.height / 3);
    path.quadraticBezierTo(
      size.width / 3,
      size.height,
      size.width,
      size.height - size.height / 2,
    );
    path.lineTo(size.width, 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
