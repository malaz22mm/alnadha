
import '../../../core/classes/crud.dart';
import '../../../core/constant/staticdata.dart';

class DriverSignupData {
  Crud crud;

  DriverSignupData(this.crud);

  postDriverSignupData({
    required String email,
    required String password,
    required String username,
    required String conpass,
    required String phone,
    required String type,
    required String vehicleNumber,
  }) async {
    var response = await crud.postData(
      linkurl: "${StaticData().baseurl}driver/auth/register",
      data: {
        'password': password,
        'email': email,
        'full_name': username,
        'phone': phone,
        'password_confirmation': conpass,
        'type': type,
        'vehicle_number': vehicleNumber,

      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
