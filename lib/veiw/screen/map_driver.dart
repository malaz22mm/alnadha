import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:alnadha/core/constant/colors.dart';
import 'dart:async';

class DriverTrackingPage extends StatefulWidget {
  const DriverTrackingPage({super.key});

  @override
  State<DriverTrackingPage> createState() => _DriverTrackingPageState();
}

class _DriverTrackingPageState extends State<DriverTrackingPage> {
  final MapController _mapController = MapController();

  // الموقع الابتدائي للسائق (مؤقت - سيتم تغييره ديناميكيًا)
  LatLng driverLocation = const LatLng(33.5138, 36.2765); // دمشق
  final LatLng customerLocation = const LatLng(33.5090, 36.3000); // باب شرقي

  // محاكاة لتحريك السائق باتجاه الزبون
  void _simulateDriverMovement() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        // تحريك الموقع خطوة بسيطة نحو الزبون
        final dx = (customerLocation.latitude - driverLocation.latitude) * 0.1;
        final dy = (customerLocation.longitude - driverLocation.longitude) * 0.1;

        driverLocation = LatLng(
          driverLocation.latitude + dx,
          driverLocation.longitude + dy,
        );
      });

      // إذا اقترب السائق كفاية، أوقف المحاكاة
      final distance = Distance().as(
        LengthUnit.Meter,
        driverLocation,
        customerLocation,
      );
      if (distance < 30) timer.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    _simulateDriverMovement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        title: const Center(child: Text('توصيل الطلب')),
      ),
      body: Column(
        children: [
          // 🗺️ الخريطة
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: driverLocation,
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: driverLocation,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.delivery_dining,
                          color: Colors.blue, size: 35),
                    ),
                    Marker(
                      point: customerLocation,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.location_pin,
                          color: Colors.red, size: 35),
                    ),
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [driverLocation, customerLocation],
                      strokeWidth: 4,
                      color: Colors.green,
                    )
                  ],
                ),
              ],
            ),
          ),

          // ℹ️ معلومات الزبون + أزرار الحالة
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("👤 الزبون: محمد العلي", style: TextStyle(color: Colors.white)),
                const Text("📍 العنوان: دمشق - باب شرقي", style: TextStyle(color: Colors.white)),
                const Text("📞 الهاتف: 0912345678", style: TextStyle(color: Colors.white)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("🚚 تم بدء التوصيل")),
                          );
                        },
                        icon: const Icon(Icons.navigation),
                        label: const Text("بدء التوصيل"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("✅ تم تسليم الطلب")),
                          );
                        },
                        icon: const Icon(Icons.check),
                        label: const Text("تم التسليم"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
