
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/driver_order_controller.dart';
import '../../core/classes/stutusconntection.dart';
import '../../core/constant/colors.dart';
import '../../core/services/services.dart';
import '../widget/custom_text.dart';

class DriverHome extends StatelessWidget {
  DriverHome({super.key});
  final DriverOrdersController controller = Get.put(DriverOrdersController());

  MyServices services = Get.find();

  @override
  Widget build(BuildContext context) {

    String? token = services.pref.getString("driver_token");
    String? name = services.pref.getString("driver_name");
    int? id = services.pref.getInt("driver_id");

    return SafeArea(


        child:Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(20.w.h),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                  const Spacer(),
                  CustomText(
                    text: "الطلبات",
                    fontSize: 30.sp,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    width: 20.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: AppColors.yellow),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list_rounded)),
                  const CustomText(text: "فلترة"),
                  const Spacer(),
                  ...List.generate(
                      2,
                          (index) => CustomText(
                        text: index == 0 ? "  " : "كافة الطلبات",
                        fontSize: 15.sp,
                      )),
                ],
              ),
      Expanded(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: GetBuilder<DriverOrdersController>(
            builder: (controller) {
              if (controller.statusRequest == StatusRequest.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.orders.isEmpty) {
                return const Center(child: Text("لا توجد طلبات حالية"));
              } else {
                return ListView.builder(
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    var order = controller.orders[index];
                    print(order['OrderID']);
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildInfoRow(Icons.two_wheeler, order['Vehicle'] ?? ''),
                            buildInfoRow(Icons.fastfood, order['Description'] ?? ''),
                            buildInfoRow(Icons.location_on, order['SourceAddress'] ?? ''),
                            buildInfoRow(Icons.flag, order['DestinationAddress'] ?? ''),
                            buildInfoRow(Icons.straighten, order['Distance'] ?? ''),
                            buildInfoRow(Icons.person, order['user']?['fullName'] ?? ''),
                            buildInfoRow(Icons.phone, order['user']?['phone'] ?? ''),
                            InkWell(
                              onTap: () { controller.acceptOrder(order['OrderID']);

                              print(token);                              },
                              child: Container(
                                width: 200.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
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
        ]
    ),
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String value) {
    return Padding(
      padding: EdgeInsets.all(4.w.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(icon, color: AppColors.black, size: 20),


            SizedBox(width: 10.w),
            CustomText(
              text: value,
            ),          ],
        ),
      ),

    );
  }
}
