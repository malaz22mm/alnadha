import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import '../../../controller/DriverTrackingController.dart';

class DriverTrackingPage extends StatefulWidget {
  final int? orderId;
  const DriverTrackingPage({Key? key, this.orderId}) : super(key: key);

  @override
  State<DriverTrackingPage> createState() => _DriverTrackingPageState();
}

class _DriverTrackingPageState extends State<DriverTrackingPage> {
  final mapController = MapController();
  bool isMapReady = false;

  int get effectiveOrderId => widget.orderId ?? (Get.arguments?['orderId'] ?? 0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverTrackingController>(
      init: DriverTrackingController()..orderId = effectiveOrderId,
      builder: (controller) {
        if (isMapReady) {
          mapController.move(controller.driverLocation, 15.0);
        }

        return Scaffold(
          appBar: AppBar(title: const Text('توصيل الطلب')),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        initialCenter: controller.driverLocation,
                        initialZoom: 15.0,
                        onMapReady: () => setState(() => isMapReady = true),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: 'com.example.alnadha',
                        ),
                        MarkerLayer(
                          markers: [
                            // أيقونة السائق 🚚
                            Marker(
                              point: controller.driverLocation,
                              width: 40,
                              height: 40,
                              child: const Icon(Icons.delivery_dining,
                                  color: Colors.blue, size: 35),
                            ),
                            // أيقونة الاستلام 📦
                            if (controller.hasPickupDelivery)
                              Marker(
                                point: controller.pickupLocation,
                                width: 40,
                                height: 40,
                                child: const Icon(Icons.store,
                                    color: Colors.green, size: 35),
                              ),
                            // أيقونة التسليم 🏁
                            if (controller.hasPickupDelivery)
                              Marker(
                                point: controller.deliveryLocation,
                                width: 40,
                                height: 40,
                                child: const Icon(Icons.flag,
                                    color: Colors.red, size: 35),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // زر "تم التسليم" عائم على الخريطة
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  icon: const Icon(Icons.check),
                  label: const Text("تم التسليم"),
                  onPressed: () {
                    controller.confirmDelivery();

                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
