import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:alnadha/core/classes/stutusconntection.dart';

import '../constant/colors.dart';
import '../constant/image.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(
        child:  CircularProgressIndicator(color:AppColors.primarycolor,))
        : statusRequest == StatusRequest.offlinefailure
        ? const Center(
        child:CircularProgressIndicator(color: AppColors.primarycolor,) ,
            )
        : statusRequest == StatusRequest.serverfailure
        ?const  Center(
        //child: Lottie.asset(AppImage.falureimage,
           // width: 250, height: 250)
    )
        : statusRequest == StatusRequest.failure
        ?const  Center(
       // child: Lottie.asset(AppImage.falureimage,
           // width: 250, height: 250, repeat: true)
    )
        : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataRequest(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
        child:CircularProgressIndicator())
        : statusRequest == StatusRequest.offlinefailure
        ? Center(
        child: Lottie.asset(AppImage.offlineimage,
            width: 250, height: 250))
        : statusRequest == StatusRequest.serverfailure
        ? Center(
        child: Lottie.asset(AppImage.serverfalureimage,
            width: 250, height: 250))
        : widget;
  }
}
