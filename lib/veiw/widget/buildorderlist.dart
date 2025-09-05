import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/colors.dart';
import '../../core/constant/staticdata.dart';
import '../../core/services/services.dart';
import '../screen/edit_order_page.dart';

Widget buildOrderList(String status, List<Map<String, dynamic>> allOrders) {

  final filteredOrders = allOrders;

  MyServices services = Get.find();


  if (filteredOrders.isEmpty) {
    return const Center(child: Text("لا يوجد طلبات في هذه الحالة"));
  }
  return ListView.builder(

    padding: const EdgeInsets.all(16),
    itemCount: filteredOrders.length,
    itemBuilder: (context, index) {
      final order = filteredOrders[index];
      if(order['Status'] == 'pending')
      {
        order['color'] = AppColors.darkbluecolor;
      order['icon'] = Icons.pending_actions;
      }
      else if(order['Status'] == 'accepted')
      {
        order['color'] = Colors.deepOrange;
        order['icon'] = Icons.directions_car;
      }
      else if(order['Status'] == 'delivered')
      {
        order['color'] = Colors.green;
        order['icon'] = Icons.done;
      }
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditOrderPage(order: order),
            ),
          );

        },
        child: Card(
          color:  AppColors.gray,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(order['icon'], color: order['color'], size: 36),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          Text("طلب #${order['OrderID'] ?? ''}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        if (order['Status'] == 'pending')  IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Get.to(EditOrderPage(order: order));
                              }
                          ),
                          if (order['Status'] == 'delivered')
                            IconButton(
                              icon: const Icon(Icons.star_rate, color: Colors.amber),
                              onPressed: () {
                                Get.toNamed('/rating', arguments: order['OrderID']);
                              },
                            ),
                          if (order['Status'] == 'accepted')
                            IconButton(
                              icon:  Icon(Icons.location_on, color: Colors.blue),
                              onPressed: () {
                                Get.toNamed(
                                  '/tracking',
                                  arguments: {
                                    'orderId': order['OrderID'],
                                    'authToken':services.pref.getString('token') ,
                                  },
                                );
                              },
                            ),

                        ],
                      ),

                      const SizedBox(height: 8),
                      Text("التفاصيل: ${order['Description'] ?? 'غير محدد'}", style: const TextStyle(fontSize: 16)),

                      const SizedBox(height: 8),
                      Row(
                        children: [

                          Icon(Icons.timer, size: 25, color: order['color']),
                          const SizedBox(width: 8),
                          Text(
                            "وقت الوصول: ${order['TravelTime'] ?? 'غير معروفة'}",
                            style: TextStyle(fontSize: 16, color: order['color'] ?? Colors.grey),
                          ),

                        ],
                      ),
                      Row(
                        children: [

                          Icon(Icons.social_distance, size: 25, color: order['color']),
                          const SizedBox(width: 8),
                          Text(
                            "المسافة: ${order['Distance'] ?? 'غير معروفة'}",
                            style: TextStyle(fontSize: 16, color: order['color'] ?? Colors.grey),
                          ),

                        ],
                      ),
                      Row(
                        children: [

                          Icon(Icons.price_change, size: 25, color: order['color']),
                          const SizedBox(width: 8),
                          Text(
                            "السعر: ${order['Cost'] ?? 'غير معروفة'}",
                            style: TextStyle(fontSize: 16, color: order['color'] ?? Colors.grey),
                          ),

                        ],
                      ),

                    ],

                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
