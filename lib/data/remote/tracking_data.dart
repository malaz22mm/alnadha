import 'dart:convert';
import 'package:alnadha/core/services/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

MyServices myServices = Get.find();
class TrackingData {
  late PusherChannelsFlutter pusher;
  Function(Map<String, dynamic>)? onLocationUpdate;
  String? _orderId;

  Future<void> initPusher(String orderId, String authUrl) async {
    _orderId = orderId;

    try {
      pusher = PusherChannelsFlutter.getInstance();

      await pusher.init(
        apiKey: "2b490112d8927e008c6d",
        cluster: "us2",
        onAuthorizer: (channelName, socketId, options) async {
          return await fetchAuth(authUrl, socketId, channelName);
        },
        onConnectionStateChange: (currentState, previousState) {
          print("Pusher Connection: $previousState -> $currentState");
        },
        onError: (message, code, error) {
          print("Pusher Error: $message, Code: $code");
        },
        onEvent: onPusherEvent,
      );

      await pusher.subscribe(channelName: "order.$orderId");
      await pusher.connect();

    } catch (e) {
      print("Pusher Init Error: $e");
    }
  }

  void onPusherEvent(PusherEvent event) {
    // print("📡 Received Event: ${event.eventName}");
    // print("📦 Raw Data: ${event.data}");
    //
    // print("=== 🔵 PUSHER EVENT RECEIVED ===");
    // print("📡 Channel: ${event.channelName}");
    // print("🎯 Event Name: ${event.eventName}");
    // print("📦 Raw Data: ${event.data}");
    // print("👤 User ID: ${event.userId}");
    // print("=================================");
    print("📡 EVENT RECEIVED");
    print("➡️ Channel: ${event.channelName}");
    print("➡️ Event: ${event.eventName}");
    print("➡️ Data: ${event.data}");

    if (onLocationUpdate != null) {
      try {
        final decoded = jsonDecode(event.data);
        print("✅ Decoded: $decoded");
      } catch (e) {
        print("❌ JSON Decode Error: $e");
      }
    }
    if (event.eventName == "driver-location-updated") {
      try {
        print("📍 Location update event detected!");
        final data = jsonDecode(event.data);
        print("📊 Parsed data: $data");

        // تحقق من وجود البيانات المطلوبة
        final lat = data['lat'];
        final lng = data['lng'];

        if (lat != null && lng != null) {
          print("✅ Valid location data: lat=$lat, lng=$lng");
          if (onLocationUpdate != null) {
            onLocationUpdate!(data);
          }
        } else {
          print("❌ Missing lat/lng in data");
        }
      } catch (e) {
        print("❌ Error parsing location data: $e");
        print("Raw data that caused error: ${event.data}");
      }
    } else if (event.eventName == "pusher:subscription_succeeded") {
      print("🎉 Successfully subscribed to channel!");
      // 🔥 إيقاف الـ loading بعد نجاح الاشتراك
      if (onLocationUpdate != null) {
        onLocationUpdate!({
          'lat': null,
          'lng': null,
          'status': 'subscribed',
        });
      }
    }
    else if (event.eventName == "pusher:ping") {
      print("💓 Pusher heartbeat ping");
    } else {
      print("ℹ️ Other event type received");
    }
  }
  String token = myServices.pref.getString("token") ?? "";

  Future<Map<String, dynamic>> fetchAuth(
      String url, String socketId, String channelName) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        },
        body: {
          'socket_id': socketId,
          'channel_name': channelName,
        },
      );

      if (response.statusCode == 200) {
        print("=============================");
        print(response);
        return jsonDecode(response.body);
      } else {
        throw Exception('Auth failed: ${response.statusCode}');
      }
    } catch (e) {
      print("Auth Error: $e");
      rethrow;
    }
  }

  Future<void> disconnect() async {
    try {
      await pusher.unsubscribe(channelName: "order.$_orderId");
      await pusher.disconnect();
    } catch (e) {
      print("Disconnect Error: $e");
    }
  }
}