import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alnadha/controller/order_controller.dart';

import '../widget/buildorderlist.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late OrderController orderController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    orderController = Get.put(OrderController());

    // تحميل الطلبات حسب الحالة
    orderController.loadOrders("pending");
    orderController.loadOrders("accepted");
    orderController.loadOrders("delivered");
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'تتبع الطلبات',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.blue,
                      child: Text("1", style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    SizedBox(width: 6),
                    Text('بانتظار السائق'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.blue,
                      child: Text("2", style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    SizedBox(width: 6),
                    Text('قيد التوصيل'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.blue,
                      child: Text("3", style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    SizedBox(width: 6),
                    Text('تم التوصيل'),
                  ],
                ),
              ),
            ],

          ),

        ),
        body: GetBuilder<OrderController>(
          builder: (controller) => TabBarView(
            controller: _tabController,
            children: [
              buildOrderList('بانتظار السائق', List<Map<String, dynamic>>.from(controller.ordersByStatus['pending'] ?? [])),
              buildOrderList('قيد التوصيل', List<Map<String, dynamic>>.from(controller.ordersByStatus['accepted'] ?? [])),
              buildOrderList('تم التوصيل', List<Map<String, dynamic>>.from(controller.ordersByStatus['delivered'] ?? [])),
            ],
          ),


        ),

      ),
    );
  }
}
