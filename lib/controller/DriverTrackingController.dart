import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/classes/stutusconntection.dart';
import '../../../core/services/services.dart';
import '../data/remote/DriverLocationData.dart';

class DriverTrackingController extends GetxController {
  final DriverLocationData locationData = DriverLocationData(Get.find());
  final MyServices services = Get.find();

  var driverLocation = LatLng(33.5090, 36.3000).obs;
  var pickupLocation = LatLng(0,0).obs;
  var deliveryLocation = LatLng(0,0).obs;

  var hasPickupDelivery = false.obs;
  StatusRequest statusRequest = StatusRequest.none;

  late StreamSubscription<Position> positionStream;
  var orderId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLocationPermission();
  }

  Future<void> confirmDelivery() async {
    String? token = services.pref.getString("driver_token");
    if (token == null) return;

    var response = await locationData.completeOrder(
      orderId: orderId.value,
      token: token,
    );

    if (response["status"] == "Success") {
      Get.snackbar(
        "نجاح",
        "تم تأكيد تسليم الطلب ✅",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      services.pref.remove("active_order_id");
      Get.toNamed("/driverorder");
    } else {
      Get.snackbar(
        "خطأ",
        "فشل في تأكيد التسليم: ${response["message"]}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _checkLocationPermission() async {
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

    if (permission == LocationPermission.deniedForever) return;

    startUpdatingLocation();
  }

  void startUpdatingLocation() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
      ),
    ).listen((Position position) async {
      driverLocation.value = LatLng(position.latitude, position.longitude);
      await sendDriverLocation();
    });
  }

  Future<void> sendDriverLocation() async {
    String? token = services.pref.getString("driver_token");
    print("token: $token");
    if (token == null) return;

    var response = await locationData.updateDriverLocation(
      orderId: orderId.value,
      latitude: driverLocation.value.latitude,
      longitude: driverLocation.value.longitude,
      token: token,
    );

    if (response["status"] == "Success" && !hasPickupDelivery.value && response["data"] != null) {
      pickupLocation.value = LatLng(
        double.parse(response["data"]["pickup_latitude"]),
        double.parse(response["data"]["pickup_longitude"]),
      );
      deliveryLocation.value = LatLng(
        double.parse(response["data"]["delivery_latitude"]),
        double.parse(response["data"]["delivery_longitude"]),
      );
      hasPickupDelivery.value = true;
    }
  }

  @override
  void onClose() {
    positionStream.cancel();
    super.onClose();
  }
}
