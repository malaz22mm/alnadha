import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:alnadha/core/constant/colors.dart';
import '../../controller/creat_order_controller.dart';
import '../../core/constant/routing.dart';
import 'map.dart';
class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pickupLatController = TextEditingController();
  final TextEditingController _pickupLngController = TextEditingController();
  final TextEditingController _deliveryLatController = TextEditingController();
  final TextEditingController _deliveryLngController = TextEditingController();

  String? _selectedVehicle;
  String? _selectedStatus = "pending";

  bool _isLoading = false;



  late String token;

  @override
  void initState() {
    super.initState();
    token = Get.arguments['token'] ?? '';
    print('📦 Token received: $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.transparent, // شفاف
      elevation: 1, // بدون ظل
      title: const Text("إنشاء طلب توصيل"),
      centerTitle: true,
    ),

    body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Card(
              color:  AppColors.gray,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedVehicle,
                      hint: const Text("اختر نوع المركبة"),
                      items: ['car', 'motorcycle', 'truck','bicycle']
                          .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedVehicle = val),
                      validator: (val) => val == null ? "الرجاء اختيار نوع المركبة" : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: "وصف الطلب",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (val) =>
                      val == null || val.isEmpty ? "الوصف مطلوب" : null,
                    ),
                    const SizedBox(height: 16),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/photo_2025-07-17_00-09-43.jpg',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MapScreen()),
                            );

                            if (result != null && result is Map) {
                              final LatLng pickup = result['pickup'];
                              final LatLng delivery = result['delivery'];

                              setState(() {
                                _pickupLatController.text = pickup.latitude.toString();
                                _pickupLngController.text = pickup.longitude.toString();
                                _deliveryLatController.text = delivery.latitude.toString();
                                _deliveryLngController.text = delivery.longitude.toString();
                              });
                            }
                          },

                        icon: const Icon(Icons.map, color: AppColors.black),
                        label: const Text(
                          'اختر المواقع من الخريطة',
                          style: TextStyle(color: AppColors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.white30,
                          elevation: 2,
                        ),
                      ),
                    ),
                    if (_pickupLatController.text.isNotEmpty && _deliveryLatController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("📍 الانطلاق: ${_pickupLatController.text}, ${_pickupLngController.text}"),
                            Text("📍 الوجهة: ${_deliveryLatController.text}, ${_deliveryLngController.text}"),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading
                            ? null
                            : () async {
                          if (!_formKey.currentState!.validate()) return;

                          if (_pickupLatController.text.isEmpty || _pickupLngController.text.isEmpty ||
                              _deliveryLatController.text.isEmpty || _deliveryLngController.text.isEmpty) {
                            Get.snackbar("تنبيه", "الرجاء تحديد مواقع الانطلاق والتوصيل من الخريطة",
                                snackPosition: SnackPosition.BOTTOM);
                            return;
                          }

                          setState(() => _isLoading = true);

                          try {
                            final createOrderController = Get.put(CreateOrderController());
                            createOrderController.token = token;
                            await createOrderController.orderData.postOrderData(
                              token: token,
                              vehicleTypes: _selectedVehicle!,
                              description: _descriptionController.text,
                              pickupLatitude: _pickupLatController.text,
                              pickupLongitude: _pickupLngController.text,
                              deliveryLatitude: _deliveryLatController.text,
                              deliveryLongitude: _deliveryLngController.text,
                              status: _selectedStatus!,
                            );

                            Get.snackbar("نجاح", "تم إرسال الطلب بنجاح", snackPosition: SnackPosition.BOTTOM);
                            print("Order created successfully");
                            Get.toNamed(AppRoute.order);

                            // final webhookUrl = Uri.parse("https://alnadha.app.n8n.cloud/webhook/neworder");
                            // final response = await http.post(
                            //   webhookUrl,
                            //   body: jsonEncode({
                            //     "vehicle_types": _selectedVehicle!,
                            //     "description": _descriptionController.text
                            //   }),
                            // );
                            //
                            // if (response.statusCode == 200) {
                            //   print("Webhook notification sent successfully ✅");
                            //   print("Response: ${response.body}");
                            // } else {
                            //   print("Failed to send webhook notification ❌: ${response.statusCode}, ${response.body}");
                            // }

                          } catch (e) {
                            Get.snackbar("خطأ", "فشل في إرسال الطلب: $e", snackPosition: SnackPosition.BOTTOM);
                            print("Failed to create order: $e");
                          } finally {
                            setState(() => _isLoading = false);
                          }
                        },

                        icon: const Icon(Icons.send, color: Colors.white),
                        label: _isLoading
                            ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          "إرسال الطلب",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkbluecolor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
