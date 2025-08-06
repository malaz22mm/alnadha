import '../../../core/classes/crud.dart';
import '../../../core/constant/staticdata.dart';

class OrderData {
  Crud crud;

  OrderData(this.crud);

  getOrdersByStatus(String status, String token) async {
    var response = await crud.getData(
      linkurl: "${StaticData().baseurl}customer/order?status=$status",
       Token: '$token',
    );
    return response.fold((l) => l, (r) => r);
  }
}
