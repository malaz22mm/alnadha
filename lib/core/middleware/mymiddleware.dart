import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/routing.dart';
import '../services/services.dart';

class MyMiddleWare extends GetMiddleware{
  MyServices myServices=Get.find();
  @override
  int get  priority => 1;
  @override
  RouteSettings? redirect(String? route) {
    if(myServices.pref.getString("loginStatus")=="1"){
      return const RouteSettings(name:AppRoute.homepage);
    }
    return null;
  }


}