import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../controller/tracking_controller.dart';

class TrackingView extends StatelessWidget {
  final String orderId;
  final String authUrl;

  TrackingView({super.key, required this.orderId, required this.authUrl});

  final TrackingController controller = Get.put(TrackingController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startTracking(orderId, authUrl);
    });

    return Scaffold(
      appBar: AppBar(title: const Text("تتبع الطلب")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('خطأ: ${controller.errorMessage.value}'),
                ElevatedButton(
                  onPressed: () => controller.startTracking(orderId, authUrl),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        final driverLoc = controller.driverLocation.value;
        final initialLocation = driverLoc ?? const LatLng(24.7136, 46.6753); // الريال كموقع افتراضي

        return FlutterMap(
          options: MapOptions(
            initialCenter: initialLocation,
            initialZoom: 14,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.alnadha',
            ),
            if (driverLoc != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: driverLoc,
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.local_shipping,
                      color: Colors.blue,
                      size: 40,
                    ),
                  )
                ],
              ),
          ],
        );
      }),
    );
  }
}