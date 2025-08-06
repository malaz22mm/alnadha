
import 'package:get/get.dart';
import 'package:alnadha/core/constant/routing.dart';
import 'package:alnadha/veiw/screen/auth_screens/forgetpassword/forgetpassword.dart';
import 'package:alnadha/veiw/screen/auth_screens/forgetpassword/verifycodeforgetpassword.dart';
import 'package:alnadha/veiw/screen/auth_screens/login_page.dart';
import 'package:alnadha/veiw/screen/auth_screens/signup_page.dart';
import 'package:alnadha/veiw/screen/driver.dart';
 import 'package:alnadha/veiw/screen/edit_profile.dart';
import 'package:alnadha/veiw/screen/map.dart';
import 'package:alnadha/veiw/screen/onbordring_view.dart';
import 'package:alnadha/veiw/screen/show_order.dart' ;
import '../../veiw/screen/auth_screens/forgetpassword/resetpassword.dart';
import '../../veiw/screen/auth_screens/login_driver_page.dart';
import '../../veiw/screen/auth_screens/signup_driver_page.dart';
import '../../veiw/screen/create_order_page.dart';
import '../../veiw/screen/home_page.dart';
import '../../veiw/screen/main_login_screen.dart';
import '../../veiw/screen/map_driver.dart';
import '../../veiw/screen/rating_screen.dart';
import '../../veiw/screen/settings.dart';

class Routers {
  List<GetPage<dynamic>>? routers = [
   //GetPage(name: '/', page: ()=>const SplashScreen()),
    GetPage(name: AppRoute.onbording, page: ()=>const OnBordringView()),
    GetPage(name: AppRoute.mainloginpage, page:()=>const MainLoginScreen()),
    GetPage(name: AppRoute.loginpage, page: ()=>const LoginPage()),
    GetPage(name: AppRoute.signup, page: ()=>const SignupPage()),
    GetPage(name: AppRoute.edit, page: ()=>const PersonalInfoScreen()),
    GetPage(name: AppRoute.map,page: ()=> const MapScreen()),
    GetPage(name: AppRoute.editprofile, page: ()=>const EditProfilePage()),
    GetPage(name: AppRoute.rating, page: ()=>const CompletionScreen()),
    GetPage(name: AppRoute.driverloginpage, page: ()=>const LoginDriverPage()),
    GetPage(name: AppRoute.driversignup, page: ()=>const DriverSignupPage()),
    GetPage(name: AppRoute.driverorder, page: ()=> DriverHome()),
    GetPage(name: AppRoute.createorder, page: ()=>const CreateOrderPage()),
    GetPage(name: AppRoute.homepage, page: ()=>const HomePage()),
    GetPage(name: AppRoute.order, page: ()=>const OrdersPage()),
    GetPage(name: AppRoute.drivermap, page: ()=>const DriverTrackingPage()),
    GetPage(name: AppRoute.forgetpassword, page: ()=>const ForgetPassword()),
    GetPage(name: AppRoute.verifycodeforgetpasswors, page: ()=>const VerifycodeForgetPassword()),
    GetPage(name: AppRoute.resetpassword, page: ()=>const ResetPasswordScreen()),
      GetPage(name: '/', page: ()=>const DriverTrackingPage())
  ];
}
