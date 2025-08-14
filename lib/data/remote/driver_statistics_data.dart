class MonthlyStats {
  final int month;
  final int year;
  final int totalOrders;
  final int completedOrders;
  final int acceptedOrders;

  MonthlyStats({
    required this.month,
    required this.year,
    required this.totalOrders,
    required this.completedOrders,
    required this.acceptedOrders,
  });

  factory MonthlyStats.fromJson(Map<String, dynamic> json) {
    return MonthlyStats(
      month: json['month'],
      year: json['year'],
      totalOrders: json['total_orders'],
      completedOrders: json['completed_orders'],
      acceptedOrders: json['accepted_orders'],
    );
  }
}

class DriverInfo {
  final int id;
  final String fullName;
  final String? profilePicture;
  final String email;
  final String phone;
  final String vehicleType;
  final int vehicleNumber;
  final int isAvailable;
  final int totalOrders;

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
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(
      id: json['id'],
      fullName: json['full_name'],
      profilePicture: json['profile_picture'],
      email: json['email'],
      phone: json['phone'],
      vehicleType: json['vehicle_type'],
      vehicleNumber: json['vehicle_number'],
      isAvailable: json['is_available'],
      totalOrders: json['total_orders'],
    );
  }
}
