import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/remote/edit_order_data.dart';

class EditOrderController extends GetxController {
  final EditOrderData data;
  final Map<String, dynamic> order;

  EditOrderController({required this.data, required this.order});

  late TextEditingController descriptionController;
  String? selectedVehicle;

  var isLoading = false.obs;

  @override
  void onInit() {
    selectedVehicle = order['VehicleTypes'];
    descriptionController = TextEditingController(text: order['Description']);
    super.onInit();
  }
  Future<void> saveOrder() async {
    if (selectedVehicle == null || descriptionController.text.isEmpty) {
      Get.snackbar("تنبيه", "الرجاء تعبئة جميع الحقول");
      return;
    }

    isLoading.value = true;
    try {
      final success = await data.updateOrder(
        orderId: order['OrderID'],
        vehicleType: selectedVehicle!,
        description: descriptionController.text,
      );

      isLoading.value = false;

      if (success) {
        Get.back(result: true);
        Get.snackbar("نجاح", "تم تعديل الطلب بنجاح");
      } else {
        Get.snackbar("خطأ", "فشل تعديل الطلب، تحقق من البيانات أو حاول لاحقًا");
      }
    } catch (e) {
      isLoading.value = false;
      print("Failed to update order: $e");
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالخادم: $e");
    }
  }
  Future<void> deleteOrder() async {
    isLoading.value = true;
    try {
      final success = await data.deleteOrder(order['OrderID']);
      isLoading.value = false;

      if (success) {
        Get.back(result: true);
        Get.snackbar("نجاح", "تم إلغاء الطلب بنجاح");
      } else {
        Get.snackbar("خطأ", "فشل إلغاء الطلب، حاول لاحقًا");
      }
    } catch (e) {
      isLoading.value = false;
      print("Failed to cancel order: $e");
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالخادم: $e");
    }
  }

}
