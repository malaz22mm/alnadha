import '../../../core/classes/crud.dart';
import '../../../core/constant/staticdata.dart';

class RatingData {
  Crud crud;

  RatingData(this.crud);

  sendRating({
    required int orderId,
    required int rating,
    required String comment,
    required String token,
  }) async {
    var response = await crud.postData(
      linkurl: "${StaticData().baseurl}customer/orders/$orderId/rating",
      data: {
        "rating": rating.toString(),
        "comment": comment,
      },
      token: token,
    );

    return response.fold((l) => l, (r) => r);
  }
}
