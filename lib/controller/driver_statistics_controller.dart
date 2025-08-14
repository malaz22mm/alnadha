import 'dart:convert';
import 'package:alnadha/core/constant/staticdata.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../core/services/services.dart';
import '../data/model/driver_info.dart';
import '../data/model/monthly_stats.dart';

class DriverStatisticsController extends GetxController {
  var isLoading = true.obs;
  var driverData = Rxn<DriverInfo>();
  var monthlyStats = <MonthlyStats>[].obs;
  MyServices services = Get.find();

  final String baseUrl = StaticData().baseurl; // ضع رابط API الأساسي
  late  String token='';// ضع التوكن هنا أو جيبه من التخزين

  @override
  void onInit() {
    fetchDriverStats();
    fetchMonthlyStats();
    super.onInit();
  }

  // جلب بيانات السائق
  Future<void> fetchDriverStats() async {
    token = services.pref.getString("driver_token") ?? '';
    if(token.isEmpty) {
      print("Token is empty!");
      isLoading.value = false;
      return;
    }

    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse("${baseUrl}driver/stats"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData["status"] == "Success" && jsonData["data"] != null) {
          driverData.value = DriverInfo.fromJson(jsonData["data"][0]);
        }
      }
    } catch (e) {
      print("Error fetching driver stats: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // جلب بيانات الأداء الشهري
  Future<void> fetchMonthlyStats() async { token = services.pref.getString("driver_token") ?? '';
  if(token.isEmpty) {
    print("Token is empty!");
    isLoading.value = false;
    return;
  }
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}driver/MonthlyOrdersStatistics"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData["status"] == "Success" && jsonData["data"] != null) {
          final list = jsonData["data"]["data"] as List;
          monthlyStats.value =
              list.map((e) => MonthlyStats.fromJson(e)).toList();
        }
      }
      else{
        print("Error fetching monthly stats: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching monthly stats: $e");
    }
  }
}
