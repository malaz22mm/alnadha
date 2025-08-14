class DriverInfo {
  final int id;
  final String fullName;
  final String? profilePicture;
  final String email;
  final String phone;
  final String vehicleType;
  final int vehicleNumber;
  final bool isAvailable;
  final int totalOrders;
  final int completedOrders;
  final int acceptedOrders;
  final int rejectedOrders;

  DriverInfo({
    required this.id,
    required this.fullName,
    this.profilePicture,
    required this.email,
    required this.phone,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.isAvailable,
    required this.totalOrders,
    required this.completedOrders,
    required this.acceptedOrders,
    required this.rejectedOrders,
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      profilePicture: json['profile_picture'],
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      vehicleType: json['vehicle_type'] ?? '',
      vehicleNumber: json['vehicle_number'] ?? 0,
      isAvailable: json['is_available'] ?? false,
      totalOrders: json['total_orders'] ?? 0,
      completedOrders: json['completed_orders'] ?? 0,
      acceptedOrders: json['accepted_orders'] ?? 0,
      rejectedOrders: json['rejected_orders'] ?? 0,
    );
  }
}
