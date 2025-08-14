import 'dart:async';
import 'package:alnadha/core/constant/routing.dart';
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

  LatLng driverLocation = const LatLng(33.5090, 36.3000);
  LatLng pickupLocation = const LatLng(0, 0);
  LatLng deliveryLocation = const LatLng(0, 0);

  StatusRequest statusRequest = StatusRequest.none;
  late StreamSubscription<Position> positionStream;

  int orderId = 0;
  bool hasPickupDelivery = false; // عشان نعرف إذا جبنا الإحداثيات

  @override
  void onInit() {
    super.onInit();
    _checkLocationPermission();
  }
  Future<void> confirmDelivery() async {
    String? token = services.pref.getString("driver_token");
    if (token == null) return;

    var response = await locationData.completeOrder(
      orderId: orderId,
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
      Get.toNamed(AppRoute.driverorder);
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
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    startUpdatingLocation();
  }

  void startUpdatingLocation() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) async {
      driverLocation = LatLng(position.latitude, position.longitude);
      update();
      await sendDriverLocation();
    });
  }

  Future<void> sendDriverLocation() async {
    String? token = services.pref.getString("driver_token");
    if (token == null) return;

    var response = await locationData.updateDriverLocation(
      orderId: orderId,
      latitude: driverLocation.latitude,
      longitude: driverLocation.longitude,
      token: token,
    );

    if (response["status"] == "Success") {
      // نجلب مواقع pickup و delivery أول مرة فقط
      if (!hasPickupDelivery && response["data"] != null) {
        pickupLocation = LatLng(
          double.parse(response["data"]["pickup_latitude"]),
          double.parse(response["data"]["pickup_longitude"]),
        );
        deliveryLocation = LatLng(
          double.parse(response["data"]["delivery_latitude"]),
          double.parse(response["data"]["delivery_longitude"]),
        );
        hasPickupDelivery = true;
        update();
      }
    }
  }

  @override
  void onClose() {
    positionStream.cancel();
    super.onClose();
  }
}
