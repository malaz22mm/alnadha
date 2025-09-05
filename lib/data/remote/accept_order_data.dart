import '../../../core/classes/crud.dart';
import '../../../core/constant/staticdata.dart';

class DriverAcceptedOrdersData {
  Crud crud;

  DriverAcceptedOrdersData(this.crud);

  Future<dynamic> getAcceptedOrders({required String token}) async {
    var response = await crud.getData(
      linkurl: "${StaticData().baseurl}driver/getOrder?status=accepted",
      Token: token,
    );
    return response.fold((l) => l, (r) => r);
  }
}
