import 'package:dartz/dartz.dart';
import 'package:alnadha/core/classes/crud.dart';
import 'package:alnadha/core/classes/stutusconntection.dart';
import '../../../core/constant/staticdata.dart';

class ForgetPasswordData {
  Crud crud;
  ForgetPasswordData(this.crud);

  Future<Either<StatusRequest, Map>> postData(String email) async {
    try {
      var response = await crud.postData(
          linkurl: "${StaticData().baseurl}customer/auth/Send-code",
          data: {
            "email": email,
          },
          header: {
            "Accept": "application/json"
          }
      );

      if (response is Map<String, dynamic>) {
        return response;
      } else {
        return Left(StatusRequest.failure);

      }
    } catch (e) {
      return Left(StatusRequest.serverfailure);
    }
  }
}