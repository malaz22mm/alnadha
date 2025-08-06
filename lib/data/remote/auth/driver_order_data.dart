import '../../../core/classes/crud.dart';
import '../../../core/constant/staticdata.dart';

class DriverOrdersData {
  Crud crud;

  DriverOrdersData(this.crud);

  Future getOrders({required String token}) async {
    var response = await crud.getData(
      linkurl: "${StaticData().baseurl}driver/getOrder",
      Token: token,
    );
    return response.fold((l) => l, (r) => r);
  }
  Future<Map<String, dynamic>> acceptOrder({
    required int orderId,
    required String token,
  }) async {
    var response = await crud.postData(
      linkurl: "${StaticData().baseurl}driver/acceptOrder/$orderId",
      token: token,
      data: null
    );

    return response.fold(
          (l) => {"status": false, "message": l.toString()},  // إذا حدث خطأ: نعيد خريطة بخطأ
          (r) => Map<String, dynamic>.from(r),                // إذا نجح: نعيد Map بشكل صريح
    );
  }


}
