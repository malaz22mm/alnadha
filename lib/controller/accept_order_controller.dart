import 'package:get/get.dart';
import '../../../core/classes/stutusconntection.dart';
import '../../../core/services/services.dart';
import '../data/remote/accept_order_data.dart';

class DriverAcceptedOrdersController extends GetxController {
  List acceptedOrders = [];
  StatusRequest statusRequest = StatusRequest.none;
  DriverAcceptedOrdersData ordersData = DriverAcceptedOrdersData(Get.find());
  MyServices services = Get.find();

  Future<void> getAcceptedOrders() async {
    statusRequest = StatusRequest.loading;
    update();

    String? token = services.pref.getString("driver_token");
    if (token == null) {
      statusRequest = StatusRequest.failure;
      update();
      return;
    }

    var response = await ordersData.getAcceptedOrders(token: token);

    if (response["status"] == "Success" && response["data"] != null) {
      statusRequest = StatusRequest.success;
      acceptedOrders = response['data'] as List;
    } else {
      statusRequest = StatusRequest.failure;
      acceptedOrders = [];
    }
    update();
  }

  @override
  void onInit() {
    getAcceptedOrders();
    super.onInit();
  }
}
