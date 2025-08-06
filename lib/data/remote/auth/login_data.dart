


import '../../../core/classes/crud.dart';
import '../../../core/constant/staticdata.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  PostLogindata({required String email,required String password }) async {
    var response =
    await crud.postData( linkurl:"${StaticData().baseurl}customer/auth/login",data:  {
      'password': password,
      'identifier': email,
    },
    );
    return response.fold((l) => l, (r) => r);
  }
}
