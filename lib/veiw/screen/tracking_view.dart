import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:http/http.dart' as http;

class TrackingView extends StatefulWidget {
  final int orderId;
  final String authToken;

  const TrackingView({
    Key? key,
    required this.orderId,
    required this.authToken,
  }) : super(key: key);

  @override
  State<TrackingView> createState() => _DriverTrackingPageState();
}

class _DriverTrackingPageState extends State<TrackingView> {
  late PusherChannelsFlutter pusher;
  final MapController _mapController = MapController();
  LatLng? driverLocation;

  @override
  void initState() {
    print("🔑 Auth Token: ${widget.authToken}");
    super.initState();
    initPusher();
  }

  Future<void> initPusher() async {
    pusher = PusherChannelsFlutter.getInstance();

    await pusher.init(
      apiKey: "2b490112d8927e008c6d",
      cluster: "us2",
      authEndpoint: "https://al-nadha-1.onrender.com/api/broadcasting/auth",
      onAuthorizer: (channelName, socketId, options) async {
        print("🔑 Authorizing channel: $channelName with socketId: $socketId");

        try {
          final response = await http.post(
            Uri.parse("https://al-nadha-1.onrender.com/api/broadcasting/auth"),
            headers: {
              "Authorization": "Bearer ${widget.authToken}",
              "Accept": "application/json",
              "Content-Type": "application/json"
            },
            body: jsonEncode({
              "channel_name": channelName,
              "socket_id": socketId,
            }),
          );

          print("📡 Auth Response Status: ${response.statusCode}");
          print("📦 Auth Response Body: ${response.body}");

          return jsonDecode(response.body);
        } catch (e) {
          print("❌ Auth request error: $e");
          return {};
        }
      },
      onConnectionStateChange: (currentState, previousState) {
        print("🔌 Pusher connection changed: $previousState ➡️ $currentState");

        if (currentState == "CONNECTING") {
          print("⏳ Trying to connect to Pusher...");
        } else if (currentState == "CONNECTED") {
          print("✅ Successfully connected to Pusher server.");
        } else if (currentState == "DISCONNECTED") {
          print("⚠️ Disconnected from Pusher.");
        }
      },
      onError: (message, code, exception) {
        print("❌ Pusher error: $message | code: $code | exception: $exception");
      },
      onSubscriptionSucceeded: (channelName, data) {
        print("✅ Subscribed to channel: $channelName");
        print("📦 Subscription data: $data");
      },
      onEvent: (event) {
        print("📡 New event received!");
        print("➡️ Channel: ${event.channelName}");
        print("➡️ Event name: ${event.eventName}");
        print("➡️ Raw data: ${event.data}");
      },
    );

    await pusher.subscribe(
      channelName: "private-order.${widget.orderId}",
      onEvent: (event) {
        print("🎯 Event on private-order.${widget.orderId}: ${event.eventName}");
        if (event.eventName == "driver-location-updated") {
          try {
            final decoded = jsonDecode(event.data);
            print("✅ Driver location update: $decoded");

            final lat = double.tryParse(decoded["latitude"].toString());
            final lng = double.tryParse(decoded["longitude"].toString());

            if (lat != null && lng != null) {
              final newLocation = LatLng(lat, lng);
              setState(() {
                driverLocation = newLocation;
              });
              _mapController.move(newLocation, _mapController.camera.zoom);
            }
          } catch (e) {
            print("❌ JSON decode error: $e");
          }
        }
      },
    );

    await pusher.connect();
    print("🚀 Connecting to Pusher...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تتبع السائق")),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: LatLng(34.7304, 36.7094),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          if (driverLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: driverLocation!,
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.local_shipping,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
