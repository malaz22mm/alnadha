import 'package:get/get.dart';
import '../../../core/classes/stutusconntection.dart';
import '../../../core/functions/handingdatacontroller.dart';
import '../../../core/services/services.dart';
import '../data/remote/order_data.dart';

class OrderController extends GetxController {
  OrderData orderData = OrderData(Get.find());
  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;
  Map<String, List> ordersByStatus = {
    'pending': [],
    'accepted': [],
    'delivered': [],
  };

  late String token;


  Future<void> loadOrders(String orderStatus) async {
    statusRequest = StatusRequest.loading;
    update();

    token = myServices.pref.getString("token") ?? "";
    var response = await orderData.getOrdersByStatus(orderStatus, token);
    print("====== Orders $orderStatus: $response");
    print(token);
    statusRequest = handlingData(response);
    print("====== Orders $orderStatus: $statusRequest");

      if (response["status"] == "Success") {
        ordersByStatus[orderStatus] = response["data"];
        print("====== Orders $orderStatus: ${ordersByStatus[orderStatus]}");
        print("====== Orders $orderStatus: ${ordersByStatus}");
        print("====== Orders ===============: ${response["data"]}");
      } else {
        statusRequest = StatusRequest.failure;
      }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    // تحميل الطلبات لحالات مختلفة
    loadOrders("pending");
    loadOrders("accepted");
    loadOrders("delivered");
  }
}
