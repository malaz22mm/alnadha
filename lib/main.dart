import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'binding/initialbinding.dart';
import 'core/classes/crud.dart';
import 'core/classes/route.dart';
import 'core/constant/colors.dart';
import 'core/services/services.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(Crud());
  await Get.putAsync(() => MyServices().init());


  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: Routers().routers,
          initialBinding: InitialBinding(),
         // locale:const Locale('ar'),
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.darkbluecolor

          ),
        );
      },
    );
  }
}

