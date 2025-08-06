



import '../../../core/classes/crud.dart';
import '../../../core/constant/staticdata.dart';

class DriverLoginData {
  Crud crud;

  DriverLoginData(this.crud);

  PostLogindata({required String email,required String password }) async {
    var response =
    await crud.postData( linkurl:"${StaticData().baseurl}driver/auth/login",data:  {
      'password': password,
      'identifier': email,
    },
    );
    return response.fold((l) => l, (r) => r);
  }
}
