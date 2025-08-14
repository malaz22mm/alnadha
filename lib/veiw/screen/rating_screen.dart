import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/rating_controller.dart';
import '../../core/services/services.dart';
import '../../data/remote/rating_data.dart';


class CompletionScreen extends StatelessWidget {
  final int orderId;
  CompletionScreen({super.key, required this.orderId});

  final MyServices myServices = Get.find();

  @override
  Widget build(BuildContext context) {
    String? token = myServices.pref.getString("token");
print(token);
print(orderId);
    final controller = Get.put(
      RatingController(
        orderId: orderId,
        data: RatingData(Get.find()),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/rate.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '! شكرًا لك ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'كيف كانت تجربتك؟',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 24),

                  // نجوم التقييم
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                          (index) => IconButton(
                        onPressed: () =>
                            controller.setRating(index + 1),
                        icon: Icon(
                          Icons.star,
                          color: (index + 1) <= controller.rating.value
                              ? Colors.amber
                              : Colors.grey[400],
                          size: 32,
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 24),

                  // حقل الملاحظات
                  TextField(
                    onChanged: controller.setComment,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'اكتب ملاحظتك هنا...',
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // أزرار
                  Obx(() => Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.submitRating,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                            padding:
                            const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                              color: Colors.black)
                              : const Text('إرسال'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding:
                            const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('تخطي'),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
