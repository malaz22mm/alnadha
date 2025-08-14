import 'package:alnadha/core/constant/staticdata.dart';
import '../../../core/classes/crud.dart';

class ResetPasswordData {
  Crud crud;
  ResetPasswordData(this.crud);

  Future<dynamic> postData(String email, String password, String confirmPassword, String code) async {
    var response = await crud.postData(
      linkurl: "${StaticData().baseurl}customer/auth/rest-password",
      data:
      {
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "code": code,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
