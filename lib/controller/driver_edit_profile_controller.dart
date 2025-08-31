import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/services/services.dart';
import '../data/remote/driver_edit_profile_data.dart';
import '../../../core/classes/stutusconntection.dart';

class ProfileController extends GetxController {
  final myServices = Get.find<MyServices>();
  final DriverEditProfileData profileDataSource = DriverEditProfileData(Get.find());

  var isLoading = false.obs;
  var profileData = {}.obs;

  late String token;
  final carNumberController = TextEditingController();
  final carTypeController = TextEditingController();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  File? profileImage;

  @override
  void onInit() {
    super.onInit();
    final savedToken = myServices.pref.getString("driver_token");
    if (savedToken == null) {
      Get.snackbar("Error", "No token found, please login again");
      return;
    }
    token = savedToken;
    fetchProfile();
  }

  /// جلب بيانات البروفايل

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      var response = await profileDataSource.getProfile(token: token);
      print("PROFILE DATA RESPONSE: $response");

      // البيانات الحقيقية داخل المفتاح "data"
      final data = response['data'] ?? {};

      profileData.value = data;

      fullNameController.text = data["FullName"] ?? '';
      phoneController.text = data['Phone'] ?? '';
      carNumberController.text = data['CarNumber']?.toString() ?? '';
      carTypeController.text = data['CarType']?.toString() ?? '';


      // تحميل الصورة من السيرفر
      await fetchProfilePicture();
    } finally {
      isLoading.value = false;
    }
  }


// ما نرسل imagePath هنا، نستخدم endpoint الثابت
  Future<void> fetchProfilePicture() async {
    try {
      var bytes = await profileDataSource.getProfilePicture(token: token);
      profileImageBytes.value = bytes;
    } catch (e) {
      print("Error fetching profile picture: $e");
    }
  }


  var profileImageBytes = Rx<Uint8List?>(null);




  /// تحديث بيانات البروفايل
  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      final response = await profileDataSource.updateProfile(
        token: token,
        fullName: fullNameController.text,
        phone: phoneController.text,
        carNumber: carNumberController.text,
        carType: carTypeController.text,
      );


      response.fold(
            (failure) {
          // هنا نعرض الخطأ بناءً على نوع الفشل
          if (failure == StatusRequest.offlineFailure) {
            Get.snackbar("Error", "No internet connection");
          } else {
            Get.snackbar("Error", "Failed to update profile");
          }
        },
            (data) {
          // هنا تحقق من بيانات النجاح
          final status = data['status'] ?? '';
          if (status.toString().toLowerCase() == 'success') {
            // رفع الصورة لو موجودة
            if (profileImage != null) {
              profileDataSource.uploadProfilePicture(
                token: token,
                profileImage: profileImage!,
              ).then((imageResponse) {
                if (imageResponse.statusCode != 200) {
                  print(imageResponse.body);
                  Get.snackbar("Error", "Failed to upload profile picture");
                  return;
                }
              });
            }

            Get.snackbar("Success", "Profile updated successfully");
            fetchProfile();
          } else {
            Get.snackbar("Error", data['message'] ?? "Update failed");
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}