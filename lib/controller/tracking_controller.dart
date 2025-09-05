import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../data/remote/tracking_data.dart';

class TrackingController extends GetxController {
  final TrackingData service = TrackingData();
  var driverLocation = Rx<LatLng?>(null);
  var isLoading = RxBool(true);
  var errorMessage = RxString('');

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    service.disconnect();
    super.onClose();
  }

  void startTracking(String orderId, String authUrl, {LatLng? initialLocation}) {
    isLoading.value = true;
    errorMessage.value = '';

    if (initialLocation != null) {
      driverLocation.value = initialLocation;
      isLoading.value = false;
    }

    service.onLocationUpdate = (data) {
      try {
        if (data['status'] == 'subscribed') {
          isLoading.value = false; // ✅ توقف الـ loading
          return;
        }

        final lat = double.tryParse(data['lat']?.toString() ?? '');
        final lng = double.tryParse(data['lng']?.toString() ?? '');

        if (lat != null && lng != null) {
          driverLocation.value = LatLng(lat, lng);
          isLoading.value = false;
        }
      } catch (e) {
        errorMessage.value = 'Error parsing location: $e';
        isLoading.value = false;
      }
    };


    service.initPusher(orderId, authUrl).catchError((error) {
      errorMessage.value = 'Tracking error: $error';
      isLoading.value = false;
    });
  }
}