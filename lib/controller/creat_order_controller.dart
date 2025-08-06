import 'package:get/get.dart';
import '../data/remote/create_order_data.dart';

class CreateOrderController extends GetxController {
  late OrderData orderData;
  String? token; // اجلبها من صفحة تسجيل الدخول

  @override
  void onInit() {
    orderData = OrderData(Get.find());
    super.onInit();
  }

  createOrder() async {
    try {
      var response = await orderData.postOrderData(
        token: token!,
        vehicleTypes: "car",
        description: "test create order",
        pickupLatitude: "33.3162",
        pickupLongitude: "44.3661",
        deliveryLatitude: "25.2048",
        deliveryLongitude: "55.2708",
        status: "pending",
      );
      print("Order created successfully: ${response.data}");
      // تابع التعامل مع الاستجابة هنا
    } catch (e) {
      print("Failed to create order: $e");
    }
  }
}
