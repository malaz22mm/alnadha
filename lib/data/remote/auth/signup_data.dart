


import '../../../core/classes/crud.dart';
import '../../../core/constant/staticdata.dart';

class SignupData {
  Crud crud;

  SignupData(this.crud);

  PostSignUpdata({required String email,required String password,required String username,required String conpass,required String phone}) async {
    var response =
    await crud.postData( linkurl:"${StaticData().baseurl}customer/auth/register",data:  {
      'password': password,
      'email': email,
      'full_name':username,
      'phone':phone,
      'password_confirmation':conpass


    },
    );
    return response.fold((l) => l, (r) => r);
  }
}
