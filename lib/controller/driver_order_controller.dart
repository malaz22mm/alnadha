import 'package:get/get.dart';
import '../../../core/classes/stutusconntection.dart';
import '../../../core/functions/handingdatacontroller.dart';
import '../../../core/services/services.dart';
import '../core/constant/routing.dart';
import '../data/remote/auth/driver_order_data.dart';


class DriverOrdersController extends GetxController {
  List orders = [];
  StatusRequest statusRequest = StatusRequest.none;
  DriverOrdersData ordersData = DriverOrdersData(Get.find());
  MyServices services = Get.find();

  getOrders() async {
    statusRequest = StatusRequest.loading;
    update();

    String? token = services.pref.getString("driver_token");
    print("-----------------------------------------------------Token from SharedPreferences: $token");

    print("Token from SharedPreferences: $token");
    if (token == null) {
      statusRequest = StatusRequest.failure;
      update();
      return;
    }

    var response = await ordersData.getOrders(token: token);

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.seccuss) {
      orders = response['data'];
      print("Orders from API: $orders");
    } else {
      orders = [];
    }
    update();
  }
  Future<void> acceptOrder(int orderId) async {
    statusRequest = StatusRequest.loading;
    update();

    String? token = services.pref.getString("driver_token");
    if (token == null) {
      statusRequest = StatusRequest.failure;
      update();
      return;
    }

    var response = await ordersData.acceptOrder(orderId: orderId, token: token);

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.seccuss) {
      if (response['status'] == "Success") {
        Get.snackbar("نجاح", "تم قبول الطلب بنجاح");
        getOrders();
        Get.toNamed(AppRoute.drivermap, arguments: {'orderId': orderId});
      } else {
        Get.snackbar("خطأ", "فشل في قبول الطلب");
      }
    } else {
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالخادم");
    }

    update();
  }

  Future<void> rejectOrder(int orderId) async {
    statusRequest = StatusRequest.loading;
    update();

    String? token = services.pref.getString("driver_token");
    if (token == null) {
      statusRequest = StatusRequest.failure;
      update();
      return;
    }

    var response = await ordersData.rejectOrder(orderId: orderId, token: token);

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.seccuss) {
      if (response['status'] == "Success") {
        Get.snackbar("نجاح", "تم إلغاء الطلب بنجاح");
        // حذف الطلب من القائمة الحالية بدون إعادة تحميل API
        orders.removeWhere((order) => order['OrderID'] == orderId);
        update();
      } else {
        Get.snackbar("خطأ", "فشل في إلغاء الطلب");
      }
    } else {
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالخادم");
    }

    update();
  }




  @override
  void onInit() {
    getOrders();
    super.onInit();
  }


}
