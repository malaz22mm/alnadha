import 'package:get/get.dart';
import 'package:alnadha/core/constant/routing.dart';
import 'package:alnadha/veiw/screen/auth_screens/forgetpassword/forgetpassword.dart';
import 'package:alnadha/veiw/screen/auth_screens/forgetpassword/verifycodeforgetpassword.dart';
import 'package:alnadha/veiw/screen/auth_screens/login_page.dart';
import 'package:alnadha/veiw/screen/auth_screens/signup_page.dart';
import 'package:alnadha/veiw/screen/Driver/driver.dart';
 import 'package:alnadha/veiw/screen/edit_profile.dart';
import 'package:alnadha/veiw/screen/map.dart';
import 'package:alnadha/veiw/screen/onbordring_view.dart';
import 'package:alnadha/veiw/screen/show_order.dart' ;
import '../../veiw/screen/Driver/driver_edit_profile.dart';
import '../../veiw/screen/Driver/driverforgetpassword/forgetpassword.dart';
import '../../veiw/screen/Driver/driverforgetpassword/resetpassword.dart';
import '../../veiw/screen/Driver/driverforgetpassword/verifycodeforgetpassword.dart';
import '../../veiw/screen/Driver/map_driver.dart';
import '../../veiw/screen/Driver/statistics.dart';
import '../../veiw/screen/auth_screens/forgetpassword/resetpassword.dart';
import '../../veiw/screen/auth_screens/login_driver_page.dart';
import '../../veiw/screen/auth_screens/signup_driver_page.dart';
import '../../veiw/screen/create_order_page.dart';
import '../../veiw/screen/home_page.dart';
import '../../veiw/screen/main_login_screen.dart';
import '../../veiw/screen/rating_screen.dart';
import '../../veiw/screen/splash_view.dart';
import '../../veiw/screen/tracking_view.dart';

class Routers {
  List<GetPage<dynamic>>? routers = [
   GetPage(name: '/', page: ()=>const SplashScreen()),
    GetPage(name: AppRoute.onbording, page: ()=>const OnBordringView()),
    GetPage(name: AppRoute.mainloginpage, page:()=>const MainLoginScreen()),
    GetPage(name: AppRoute.loginpage, page: ()=>const LoginPage()),
    GetPage(name: AppRoute.signup, page: ()=>const SignupPage()),
    GetPage(name: AppRoute.drivereditprofile, page: ()=>const DriverEditProfilePage()),
    GetPage(name: AppRoute.map,page: ()=> const MapScreen()),
    GetPage(name: AppRoute.editprofile, page: ()=>const EditProfilePage()),
    GetPage(name: AppRoute.rating, page: ()=> CompletionScreen(orderId: Get.arguments)),
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
    GetPage(name: AppRoute.statistics, page: ()=>const DriverStatisticsPage()),
    GetPage(name: AppRoute.driverforgetpassword, page: ()=>const DriverForgetPassword()),
    GetPage(name: AppRoute.driververifycodeforgetpasswors, page: ()=>const DriverVerifycodeForgetPassword()),
    GetPage(name: AppRoute.driverresetpassword, page: ()=>const DriverResetPasswordScreen()),
    GetPage(name: AppRoute.tracking, page: ()=> TrackingView(  orderId: Get.arguments['orderId'],
      authUrl: Get.arguments['authUrl'],initialOrderLocation: Get.arguments['initialOrderLocation'],))
      // GetPage(name: '/', page: ()=>const HomePage())
  ];
}
