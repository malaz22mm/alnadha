import 'package:alnadha/core/constant/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/edit_order_controller.dart';
import '../../core/constant/colors.dart';
import '../../core/services/services.dart';
import '../../data/remote/edit_order_data.dart';

class EditOrderPage extends StatelessWidget {
  final Map<String, dynamic> order;

   EditOrderPage({Key? key, required this.order})
      : super(key: key);
  final MyServices myServices = Get.find();

  @override
  Widget build(BuildContext context) {
    String? token = myServices.pref.getString("token");
    print("Token: $token");
    final orderid = order['OrderID'];
    final controller = Get.put(
      EditOrderController(
        order: order,
        data: EditOrderData(
          baseUrl: "${StaticData().baseurl}customer/update-order",
          token:  token ?? "",

        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("تعديل الطلب"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // صورة أعلى الصفحة
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/photo_2025-07-17_00-09-42.jpg",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // اختيار نوع المركبة
            DropdownButtonFormField<String>(
              value: controller.selectedVehicle,
              items: ['car', 'bike', 'truck']
                  .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                  .toList(),
              onChanged: (val) => controller.selectedVehicle = val,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "اختر نوع المركبة",
              ),
            ),
            const SizedBox(height: 16),

            // إدخال الوصف
            TextFormField(
              controller: controller.descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "تفاصيل الطلب",
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // زر الحفظ
            Obx(
                  () => SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.saveOrder(),
                  icon: const Icon(Icons.save, color: Colors.black),
                  label: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("حفظ التعديلات",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkbluecolor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

// زر الإلغاء
            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.deleteOrder(),
                icon: const Icon(Icons.delete, color: Colors.white),
                label: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("إلغاء الطلب", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
