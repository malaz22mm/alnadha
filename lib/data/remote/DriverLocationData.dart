import '../../../core/classes/crud.dart';
import '../../../core/constant/staticdata.dart';

class DriverLocationData {
  Crud crud;
  DriverLocationData(this.crud);
  Future<Map<String, dynamic>> completeOrder({
    required int orderId,
    required String token,
  }) async {
    var response = await crud.postData(
      linkurl: "${StaticData().baseurl}driver/completeOrder/$orderId",
      data: {}, // ما في بيانات بالجسم
      token: token,
    );

    final result = response.fold(
          (l) => {
        'status': 'error',
        'message': l.toString(),
      },
          (r) => r,
    );

    if (result is Map) return Map<String, dynamic>.from(result);
    return {'status': 'error', 'message': 'unexpected response type'};
  }

  Future<Map<String, dynamic>> updateDriverLocation({
    required int orderId,
    required double latitude,
    required double longitude,
    required String token,
  }) async {
    var response = await crud.postData(
      linkurl: "${StaticData().baseurl}driver/updateDriverLocation",
      data: {
        "order_id": orderId.toString(),
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      },
      token: token,
    );

    final result = response.fold(
          (l) => {
        'status': 'error',
        'message': l.toString(),
      },
          (r) => r,
    );

    // تأكد أن ما نُعيد هو Map<String,dynamic>
    if (result is Map) return Map<String, dynamic>.from(result);
    return {'status': 'error', 'message': 'unexpected response type'};
  }
}
