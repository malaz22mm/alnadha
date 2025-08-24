import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _startLocation;
  LatLng? _destination;
  String? _startAddress;
  String? _destinationAddress;

  final MapController _mapController = MapController();
  bool _editingStart = true;

  LatLng _homsCenter = LatLng(34.7304, 36.7094);

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }


    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    LatLng current = LatLng(position.latitude, position.longitude);
    await _setStart(current);
    _mapController.move(current, 15);
  }

  Future<String> _getAddressFromLatLng(LatLng latLng) async {
    final url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?lat=${latLng.latitude}&lon=${latLng.longitude}&format=json&accept-language=ar");
    try {
      final response = await http.get(url, headers: {
        'User-Agent': 'flutter_map_demo'
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['display_name'] ?? "عنوان غير معروف";
      } else {
        return "خطأ: ${response.statusCode}";
      }
    } catch (e) {
      return "فشل في جلب العنوان";
    }
  }

  Future<void> _setStart(LatLng latLng) async {
    _startLocation = latLng;
    _startAddress = await _getAddressFromLatLng(latLng);
    setState(() {});
  }

  Future<void> _setDestination(LatLng latLng) async {
    _destination = latLng;
    _destinationAddress = await _getAddressFromLatLng(latLng);
    setState(() {});
  }

  void _onTapMap(TapPosition tapPosition, LatLng latlng) {
    if (_editingStart) {
      _setStart(latlng);
    } else {
      _setDestination(latlng);
    }
  }
  LatLng _offsetPoint(LatLng from, LatLng to, double distanceInMeters) {
    final Distance distance = const Distance();
    final bearing = distance.bearing(from, to); // زاوية الاتجاه
    return distance.offset(from, distanceInMeters, bearing);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("حدد مواقعك")),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // الخريطة
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _homsCenter,
                initialZoom: 13,
                onTap: _onTapMap,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.alnadha',
                ),
                MarkerLayer(
                  markers: [
                    if (_startLocation != null)
                      Marker(
                        width: 60,
                        height: 60,
                        point: _startLocation!,
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                                border: Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "1",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (_destination != null)
                      Marker(
                        width: 60,
                        height: 60,
                        point: _destination!,
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                                border: Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                  ],
                ),

                if (_startLocation != null && _destination != null)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [
                          _offsetPoint(_startLocation!, _destination!, 30),   // يبدأ بعد 30 متر تقريبًا من مركز الدائرة
                          _offsetPoint(_destination!, _startLocation!, 30),  // ينتهي قبل 30 متر من مركز الدائرة
                        ],
                        strokeWidth: 4,
                        color: Colors.blue,
                      ),
                    ],
                  ),

              ],
            ),
          ),

          // أزرار اختيار الانطلاق/الوجهة
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 16,
            right: 16,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _editingStart = true;
                      });
                    },
                    icon: const Icon(Icons.flag, color: Colors.white),
                    label: const Text(
                      "تحديد الانطلاق",
                      style: TextStyle(color:Colors.white,fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _editingStart ? Colors.green : Colors.grey[400],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 5,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _editingStart = false;
                      });
                    },
                    icon: const Icon(Icons.location_on, color: Colors.white),
                    label: const Text(
                      "تحديد الوجهة",
                      style: TextStyle(color:Colors.white,fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_editingStart ? Colors.red : Colors.grey[400],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 5,
                    ),
                  ),
                ),
              ],
            ),

          ),

          // 🟦 Container فوق يمين
          if (_startLocation != null && _destination != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 120,
              right: 16,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "الانطلاق: ${_startAddress ?? "جاري التحميل..."}\n"
                      "الوجهة: ${_destinationAddress ?? "جاري التحميل..."}",
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),

          // الأزرار أسفل
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: _getCurrentLocation,
                  icon: const Icon(Icons.gps_fixed),
                  label: const Text("تحديد موقعي الحالي"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: Colors.black,
                    padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_startLocation != null && _destination != null) {
                      Navigator.pop(context, {
                        'pickup': _startLocation,
                        'pickup_address': _startAddress,
                        'delivery': _destination,
                        'delivery_address': _destinationAddress,
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('يرجى تحديد الانطلاق والوجهة')),
                      );
                    }
                  },
                  icon: const Icon(Icons.check_circle, size: 24, color: Colors.white),
                  label: const Text(
                    "تأكيد المسار 🚀",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    backgroundColor: Colors.blueAccent, // 🔵 أزرق أنيق
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
