  import 'dart:io';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import '../core/services/services.dart';
  import '../data/remote/edit_profile_data.dart';
  import '../../../core/classes/stutusconntection.dart';
  import '../../../core/functions/handingdatacontroller.dart';

  class ProfileController extends GetxController {
    final myServices = Get.find<MyServices>();
    final EditProfileData profileDataSource = EditProfileData(Get.find());

    var isLoading = false.obs;
    var profileData = {}.obs;

    late String token;
    final fullNameController = TextEditingController();
    final phoneController = TextEditingController();
    File? profileImage;

    @override
    void onInit() {
      super.onInit();
      final savedToken = myServices.pref.getString("token");
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

        if (response.isNotEmpty) {
          profileData.value = response['data'];
          fullNameController.text = profileData['fullName'] ?? '';
          phoneController.text = profileData['phone'] ?? '';
        }
      } finally {
        isLoading.value = false;
      }
    }


    /// تحديث بيانات البروفايل
    Future<void> updateProfile() async {
      try {
        isLoading.value = true;

        final response = await profileDataSource.updateProfile(
          token: token,
          fullName: fullNameController.text,
          phone: phoneController.text,
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