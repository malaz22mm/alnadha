import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/constant/staticdata.dart';

class EditOrderData {
  final String baseUrl;
  final String token;

  EditOrderData({required this.baseUrl, required this.token});

  Future<bool> updateOrder({
    required int orderId,
    required String vehicleType,
    required String description,
  }) async {
    final url = "$baseUrl/$orderId";
    print("PUT Request URL: $url");

    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({
        "vehicle_types": vehicleType,
        "description": description,
      }),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    return response.statusCode == 200;
  }

  Future<bool> deleteOrder(int orderId) async {
    final url = "${StaticData().baseurl}customer/delete-order/$orderId";
    print("DELETE Request URL: $url");

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    return response.statusCode == 200;
  }
}
