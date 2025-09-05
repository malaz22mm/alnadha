import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/accept_order_controller.dart';
import '../../../core/classes/stutusconntection.dart';
import '../../../core/constant/colors.dart';
import '../../../core/constant/routing.dart';
import '../../widget/buildinforow.dart';

class DriverAcceptedOrdersView extends StatelessWidget {
  DriverAcceptedOrdersView({super.key});
  final DriverAcceptedOrdersController controller =
  Get.put(DriverAcceptedOrdersController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("الطلبات المقبولة"),
          centerTitle: true,
          backgroundColor: AppColors.yellow,
        ),
        body: Padding(
          padding: EdgeInsets.all(20.w),
          child: GetBuilder<DriverAcceptedOrdersController>(
            builder: (controller) {
              if (controller.statusRequest == StatusRequest.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.acceptedOrders.isEmpty) {
                return const Center(child: Text("لا توجد طلبات مقبولة"));
              } else {
                return ListView.builder(
                  itemCount: controller.acceptedOrders.length,
                  itemBuilder: (context, index) {
                    var order = controller.acceptedOrders[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
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
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildInfoRow(Icons.confirmation_number,
                                "ID: ${order['OrderID']}"),
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
                            buildInfoRow(Icons.access_time,
                                order['TravelTime'] ?? ''),
                            buildInfoRow(Icons.person,
                                order['user']?['fullName'] ?? ''),
                            buildInfoRow(Icons.monetization_on,
                                order['Cost']?.toString() ?? ''),
                            buildInfoRow(Icons.date_range,
                                order['created_at'] ?? ''),

                            SizedBox(height: 10.h),

                            // 🔘 زر عرض الخريطة
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.yellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                onPressed: () {
                                  Get.toNamed(AppRoute.drivermap, arguments: {
                                    'orderId': order['OrderID'],
                                  });
                                },
                                icon: const Icon(Icons.map, color: Colors.white),
                                label: const Text(
                                  "عرض على الخريطة",
                                  style: TextStyle(color: Colors.white),
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
    );
  }
}
