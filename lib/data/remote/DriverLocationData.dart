import '../../../core/classes/crud.dart';
import '../../../core/constant/staticdata.dart';

class DriverLocationData {
  final Crud crud;
  DriverLocationData(this.crud);

  Future<Map<String, dynamic>> completeOrder({
    required int orderId,
    required String token,
  }) async {
    var response = await crud.postData(
      linkurl: "${StaticData().baseurl}driver/completeOrder/$orderId",
      data: {},
      token: token,
    );

    final result = response.fold<Map<String, dynamic>>(
          (l) => {'status': 'error', 'message': l.toString()},
          (r) => Map<String, dynamic>.from(r as Map),
    );

    return result;
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
          (l) => {'status': 'error', 'message': l.toString()},
          (r) => r,
    );

    if (result is Map) return Map<String, dynamic>.from(result);
    return {'status': 'error', 'message': 'unexpected response type'};
  }
}
