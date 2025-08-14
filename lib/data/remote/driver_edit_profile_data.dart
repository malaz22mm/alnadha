import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../core/classes/crud.dart';
import '../../core/classes/stutusconntection.dart';
import '../../core/constant/staticdata.dart';

class DriverEditProfileData {
  String baseUrl = StaticData().baseurl;

  Crud crud;

  DriverEditProfileData(this.crud);

  /// جلب بيانات البروفايل
  Future<Map<String, dynamic>> getProfile({required String token}) async {
    var response = await crud.getData(
      linkurl: "${StaticData().baseurl}driver/profile",
      Token: token,
    );

    return response.fold(
          (error) => throw Exception(error.toString()),
          (data) => data as Map<String, dynamic>,
    );
  }
  ///جلب الصورة
  // Future<Uint8List> getProfilePicture({required String token}) async {
  //   var uri = Uri.parse("${StaticData().baseurl}driver/profile_picture");
  //   var response = await http.get(
  //     uri,
  //     headers: {
  //       "Authorization": "Bearer $token",
  //       "Accept": "application/json",
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return response.bodyBytes; // الصورة كـ Bytes
  //   } else {
  //     print("Error fetching profile picture: ${response.statusCode}");
  //     throw Exception("Failed to load profile picture");
  //   }
  // }

  Future<Uint8List> getProfilePicture({required String token}) async {
    final response = await http.get(
      Uri.parse("https://al-nadha-1.onrender.com/api/driver/profile_picture"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
print(response);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception("Failed to load profile picture: ${response.statusCode}");
    }
  }



  /// تحديث بيانات البروفايل
  Future<Either<StatusRequest, Map<String, dynamic>>> updateProfile({
    required String token,
    required String fullName,
    required String phone,
  }) async {
    final data = {
      "full_name": fullName,
      "phone": phone,
    };

    return await crud.putData(
      linkurl: "${baseUrl}driver/updateProfile",
      data: data,
      token: token,
    );
  }

  /// رفع صورة الملف الشخصي
  Future<http.Response> uploadProfilePicture({
    required String token,
    required File profileImage,
  }) async {
    var uri = Uri.parse("${baseUrl}driver/profile_picture");
    var request = http.MultipartRequest("POST", uri);

    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Accept": "application/json",
    });

    request.files.add(await http.MultipartFile.fromPath(
      "profile_picture",
      profileImage.path,
    ));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }
}

