import 'package:get/get.dart';
import '../core/services/services.dart';
import '../data/remote/rating_data.dart';

class RatingController extends GetxController {
  final RatingData data;
  final int orderId;
  MyServices myServices = Get.find();

  RatingController({required this.data, required this.orderId});

  var rating = 0.obs;
  var comment = "".obs;
  var isLoading = false.obs;

  void setRating(int value) {
    rating.value = value;
  }

  void setComment(String value) {
    comment.value = value;
  }

  Future<void> submitRating() async {
    if (rating.value == 0) {
      Get.snackbar("تنبيه", "الرجاء اختيار التقييم");
      return;
    }

    isLoading.value = true;
    String token = myServices.pref.getString("token") ?? "";

    final success = await data.sendRating(

      orderId: orderId,
      rating: rating.value,
      comment: comment.value,
       token: token
    );
    isLoading.value = false;

    if (success==200) {
      Get.snackbar("نجاح", "تم إرسال التقييم بنجاح");
      Get.back();
    } else {
      print("Rating submission failed");
      print(success);
      Get.snackbar("خطأ", "فشل إرسال التقييم");
    }
  }
}
