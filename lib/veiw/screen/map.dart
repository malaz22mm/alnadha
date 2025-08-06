import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _startLocation;
  LatLng? _destination;
  final MapController _mapController = MapController();
  bool _usedCurrentLocation = false;
  bool _editingStart = true; // بشكل افتراضي نحرر موقع الانطلاق


  // حمص: الموقع الافتراضي
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
    setState(() {
      _startLocation = current;
      _usedCurrentLocation = true; // المستخدم استخدم الزر
    });
    _mapController.move(current, 15);
  }


  void _onTapMap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      if (_editingStart) {
        _startLocation = latlng;
      } else {
        _destination = latlng;
      }
    });
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
          // الخريطة تغطي كامل الشاشة
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
                        width: 50,
                        height: 50,
                        point: _startLocation!,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _editingStart = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text(
                                  'اضغط على الخريطة لتغيير موقع الانطلاق')),
                            );
                          },
                          child: const Icon(
                              Icons.my_location, color: Colors.green, size: 36),
                        ),
                      ),
                    if (_destination != null)
                      Marker(
                        width: 50,
                        height: 50,
                        point: _destination!,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _editingStart = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text(
                                  'اضغط على الخريطة لتغيير الوجهة')),
                            );
                          },
                          child: const Icon(
                              Icons.location_on, color: Colors.red, size: 36),
                        ),
                      ),
                  ],
                ),
                if (_startLocation != null && _destination != null)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [_startLocation!, _destination!],
                        strokeWidth: 4,
                        color: Colors.blue,
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // أزرار تحديد نوع النقطة
          Positioned(
            top: MediaQuery
                .of(context)
                .padding
                .top + 60,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _editingStart = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _editingStart ? Colors.green : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text("تحديد الانطلاق"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _editingStart = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_editingStart ? Colors.red : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text("تحديد الوجهة"),
                ),
              ],
            ),
          ),

          // أزرار الأسفل
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),
                if (_startLocation != null && _destination != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "الانطلاق: ${_startLocation!.latitude.toStringAsFixed(
                          5)}, ${_startLocation!.longitude.toStringAsFixed(
                          5)}\n"
                          "الوجهة: ${_destination!.latitude.toStringAsFixed(
                          5)}, ${_destination!.longitude.toStringAsFixed(5)}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (_startLocation != null && _destination != null) {
                      Navigator.pop(context, {
                        'pickup': _startLocation,
                        'delivery': _destination,
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('يرجى تحديد الانطلاق والوجهة')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('تأكيد المواقع'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
