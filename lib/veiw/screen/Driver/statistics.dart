import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../controller/driver_statistics_controller.dart';
import '../../../core/constant/colors.dart';

class DriverStatisticsPage extends StatelessWidget {
  const DriverStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverStatisticsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "الإحصائيات",
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.yellow,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final driver = controller.driverData.value;
        if (driver == null) {
          return const Center(child: Text("لا توجد بيانات للسائق"));
        }

        String profilePicture = driver.profilePicture ??
            "https://cdn-icons-png.flaticon.com/512/149/149071.png";

        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // بطاقة السائق
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(profilePicture),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                driver.fullName,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo'),
                              ),
                              const SizedBox(height: 4),
                              Text("المركبة: ${driver.vehicleType}"),
                              Text("الهاتف: ${driver.phone}"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // الكروت
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard("إجمالي الطلبات", "${driver.totalOrders}", Colors.blueAccent),
                    _buildStatCard("مكتملة", "${driver.completedOrders}", Colors.green),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard("مرفوضة", "${driver.rejectedOrders}", Colors.redAccent),
                    _buildStatCard("مقبولة", "${driver.acceptedOrders}", Colors.orange),
                  ],
                ),

                const SizedBox(height: 24),

                // رسم بياني
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "الأداء الشهري",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 250,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles:
                          SideTitles(showTitles: true, reservedSize: 40),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) {
                              const months = [
                                "ينا", "فبر", "مار", "أب", "ماي", "يون",
                                "يول", "أغس", "سبت", "أكت", "نوف", "ديس"
                              ];
                              if (value >= 0 && value < months.length) {
                                return Text(months[value.toInt()],
                                    style: const TextStyle(fontSize: 12));
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          spots: controller.monthlyStats
                              .map((stat) => FlSpot(
                            (stat.month - 1).toDouble(),
                            stat.totalOrders.toDouble(),
                          ))
                              .toList(),
                          color: AppColors.darkbluecolor,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontFamily: 'Cairo'),
            ),
          ],
        ),
      ),
    );
  }
}
