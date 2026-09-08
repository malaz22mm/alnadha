# Alnadha Delivery & Driver Tracking App

A cross-platform Flutter application that connects customers with delivery drivers and supports the complete delivery workflow—from account creation and order placement to live driver tracking, delivery confirmation, and service ratings.

The application provides separate customer and driver experiences backed by authenticated REST APIs and real-time Pusher channels.

## Key features

### Customer experience

- Account registration, login, and password recovery
- Profile viewing and editing, including image upload
- Delivery-order creation with pickup and destination locations
- Current and previous order views
- Live driver tracking on an interactive map
- Delivery completion and driver rating workflow

### Driver experience

- Dedicated driver registration, login, and password recovery
- Available-order review with accept and reject actions
- Active and accepted order management
- Background location updates during delivery
- Delivery confirmation
- Driver profile and vehicle information management
- Performance summary and monthly order statistics

## Technology stack

| Area | Technologies |
| --- | --- |
| Application | Flutter, Dart |
| State and navigation | GetX |
| Networking | HTTP, Dio, authenticated REST APIs |
| Real-time updates | Pusher Channels, WebSocket Channel |
| Maps and location | flutter_map, Geolocator, Geocoding, latlong2 |
| Local persistence | SharedPreferences |
| Visualization | fl_chart |
| Responsive UI | flutter_screenutil, Lottie |
| Media and permissions | image_picker, permission_handler |

## Architecture

The codebase separates application responsibilities into:

- `lib/controller/` — screen state and workflow coordination
- `lib/data/remote/` — API and real-time service access
- `lib/data/model/` — typed application models
- `lib/core/` — routing, shared services, networking, constants, and utilities
- `lib/veiw/` — screens and reusable UI widgets

GetX is used for dependency injection, navigation, and reactive state. Access tokens and lightweight session data are stored locally through SharedPreferences and attached to authenticated API requests.

## Delivery tracking flow

1. A customer creates an order with pickup and delivery coordinates.
2. A driver reviews and accepts the order.
3. The driver application reads device location updates through Geolocator.
4. Authenticated coordinates are sent to the backend.
5. The customer subscribes to the private order channel and receives live location events.
6. The driver confirms delivery and the customer can submit a rating.

## Getting started

### Prerequisites

- Flutter SDK compatible with Dart `^3.8.1`
- Android Studio or Xcode for mobile development
- Access to the companion backend API
- Pusher Channels client configuration for real-time tracking

### Installation

```bash
git clone https://github.com/malaz22mm/alnadha.git
cd alnadha
flutter pub get
```

Before running the app, configure the backend base URL in `lib/core/constant/staticdata.dart` and the Pusher client settings used by the tracking modules. Use public client configuration only; backend secrets must never be included in the mobile application.

Then run:

```bash
flutter run
```

Location-based features require location permissions and an enabled device location service.

## Quality checks

```bash
flutter analyze
flutter test
```

## Project status

This is a portfolio and development project demonstrating a complete mobile delivery flow, dual-role user experiences, REST integration, geolocation, and real-time communication.

Current improvement priorities include centralizing environment configuration, replacing debug logging, moving tokens to secure device storage, removing committed build artifacts, and expanding automated test coverage.

## Author

[Malaz Solieman](https://github.com/malaz22mm) · [LinkedIn](https://www.linkedin.com/in/malaz-solieman-382045251)

