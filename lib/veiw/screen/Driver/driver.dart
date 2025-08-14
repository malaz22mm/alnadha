import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/driver_edit_profile_controller.dart';
import '../../../controller/driver_order_controller.dart';
import '../../../core/classes/stutusconntection.dart';
import '../../../core/constant/colors.dart';
import '../../../core/constant/routing.dart';
import '../../../core/services/services.dart';
import '../../widget/buildinforow.dart';
import '../../widget/custom_text.dart';

class DriverHome extends StatelessWidget {
  DriverHome({super.key});
  final DriverOrdersController controller = Get.put(DriverOrdersController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final profileController = Get.put(ProfileController());
  MyServices services = Get.find();

  @override
  Widget build(BuildContext context) {
    String? token = services.pref.getString("driver_token");
    String? name = services.pref.getString("driver_name");
    int? id = services.pref.getInt("driver_id");

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: Column(
            children: [
              // الهيدر المخصص
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFD54F), Color(0xFFFFC107)], // أصفر متدرج
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        backgroundImage: profileController.profileImageBytes.value != null
                            ? MemoryImage(profileController.profileImageBytes.value!)
                            : const AssetImage("assets/images/logo1.png") as ImageProvider,
                      );
                    }),

                    const SizedBox(height: 10),
                    Text(
                      name ?? "",
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "مرحباً بك",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              // القائمة
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit, color: Colors.blueAccent),
                      title: const Text(
                        "تعديل بيانات السائق",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      onTap: () => Get.toNamed(AppRoute.drivereditprofile),
                    ),

                    ListTile(
                      leading: const Icon(Icons.bar_chart, color: Colors.orangeAccent),
                      title: const Text(
                        "الإحصائيات",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        Get.toNamed(AppRoute.statistics);


                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.redAccent),
                      title: const Text(
                        "تسجيل خروج",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        services.pref.remove("driver_token");
                        services.pref.remove("driver_name");
                        services.pref.remove("driver_id");
                        Get.offAllNamed("/login");
                      },
                    ),
                  ],
                ),
              ),

              // الفوتر
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: const Text(
                  "نسخة التطبيق 1.0.0",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),


        body: Padding(
          padding: EdgeInsets.all(20.w.h),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                  const Spacer(),
                  CustomText(
                    text: "الطلبات",
                    fontSize: 30.sp,
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    width: 20.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: AppColors.yellow,
                    ),
                  ),
                ],
              ),
              Row(
                children: [

                  const Spacer(),
                  ...List.generate(
                    2,
                        (index) => CustomText(
                      text: index == 0 ? "  " : "كافة الطلبات",
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: GetBuilder<DriverOrdersController>(
                    builder: (controller) {
                      if (controller.statusRequest ==
                          StatusRequest.loading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (controller.orders.isEmpty) {
                        return const Center(
                            child: Text("لا توجد طلبات حالية"));
                      } else {
                        return ListView.builder(
                          itemCount: controller.orders.length,
                          itemBuilder: (context, index) {
                            var order = controller.orders[index];
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 20.h),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                                color: AppColors.gray,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(7.w.h),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    buildInfoRow(Icons.two_wheeler,
                                        order['Vehicle'] ?? ''),
                                    buildInfoRow(Icons.fastfood,
                                        order['Description'] ?? ''),
                                    buildInfoRow(Icons.location_on,
                                        order['SourceAddress'] ?? ''),
                                    buildInfoRow(Icons.flag,
                                        order['DestinationAddress'] ?? ''),
                                    buildInfoRow(Icons.straighten,
                                        order['Distance'] ?? ''),
                                    buildInfoRow(
                                        Icons.person,
                                        order['user']?['fullName'] ??
                                            ''),
                                    buildInfoRow(Icons.phone,
                                        order['user']?['phone'] ?? ''),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller
                                                .acceptOrder(order['OrderID']);
                                          },
                                          child: Container(
                                            width: 200.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15.r),
                                              color: AppColors.yellow,
                                            ),
                                            child: const Center(
                                              child: CustomText(
                                                text: "موافق",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25.w,
                                        )
                                        ,
                                        InkWell(
                                          onTap: () {
                                            controller.rejectOrder(order['OrderID']);

                                          },
                                          child: Container(
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20.r),
                                              color: Colors.red,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                color: Colors.white,
                                               Icons.cancel
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


