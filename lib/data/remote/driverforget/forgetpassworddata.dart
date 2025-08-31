import 'package:dartz/dartz.dart';
import 'package:alnadha/core/classes/crud.dart';
import 'package:alnadha/core/classes/stutusconntection.dart';
import '../../../core/constant/staticdata.dart';

class DriverForgetPasswordData {
  Crud crud;
  DriverForgetPasswordData(this.crud);

  Future<Either<StatusRequest, Map<String, dynamic>>> postData(String email) async {
    try {
      var response = await crud.postData(
        linkurl: "${StaticData().baseurl}driver/auth/Send-code",
        data: {
          "email": email,
        },
        header: {
          "Accept": "application/json"
        },
      );

      return response.fold(
            (failure) => Left(failure as StatusRequest), // الخطأ
            (success) {
          if (success is Map<String, dynamic>) {
            return Right(success); // نجاح
          } else {
            return Left(StatusRequest.failure);
          }
        },
      );
    } catch (e) {
      return Left(StatusRequest.serverFailure); // خطأ سيرفر
    }
  }
}