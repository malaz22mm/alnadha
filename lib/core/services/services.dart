import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyServices extends GetxService{
  late SharedPreferences pref;
  Future<MyServices> init()async{
    pref=await SharedPreferences.getInstance();
    return this;
  }
}

