import '../../../core/classes/crud.dart';
import '../../../core/constant/staticdata.dart';

class OrderData {
  Crud crud;
  OrderData(this.crud);
  Future<dynamic> postOrderData({
    required String token,
    required String vehicleTypes,
    required String description,
    required String pickupLatitude,
    required String pickupLongitude,
    required String deliveryLatitude,
    required String deliveryLongitude,
    required String status,
  }) async {
    var response = await crud.postData(
      linkurl: "${StaticData().baseurl}customer/order", // استبدل الرابط بقاعدة بياناتك
      data: {
        "vehicle_types": vehicleTypes,
        "description": description,
        "pickup_latitude": pickupLatitude,
        "pickup_longitude": pickupLongitude,
        "delivery_latitude": deliveryLatitude,
        "delivery_longitude": deliveryLongitude,
        "status": status,
      },
      token: token, // تعديل صغير: تأكد أن `crud` يدعم التوكن في الهيدر إذا احتجت
    );
    return response.fold((l) => l, (r) => r);
  }
}
