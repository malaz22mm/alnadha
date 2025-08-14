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
