import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  final String baseUrl;

  OrderService(this.baseUrl);

  Future<List<Map<String, dynamic>>> fetchOrdersByStatus(String status) async {
    final response = await http.get(Uri.parse('$baseUrl/customer/order?status=$status'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['status'] == 'Success' && jsonData['data'] != null) {
        List orders = jsonData['data'];
        return orders.cast<Map<String, dynamic>>();
      } else {
        throw Exception('No data found');
      }
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
