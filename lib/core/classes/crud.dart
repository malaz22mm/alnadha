import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:alnadha/core/classes/stutusconntection.dart';
import '../functions/checkinternet.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(
      {required String linkurl, data,token}) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept-Language": "en",
    };
   if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
   }
      if (await checkInternet()) {
        var response = await http.post(Uri.parse(linkurl), body: data, headers:headers );
        print(response.body);
        //Get.defaultDialog(title: "${response.body}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          print(responsebody) ; 
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
  }
  /////////////////////////////////////////////////
  //////////////GetData////////////////////////////
  /////////////////////////////////////////////////
  Future<Either<StatusRequest, Map<String, dynamic>>> getData(
      {required String linkurl, required String Token}) async {
    Map<String, String> header = {
      "Accept": "application/json",
      "Accept-Language": "en",
    };
    header.addAll({"Authorization": "Bearer $Token"});
  
    if (await checkInternet()) {
      var response = await http.get(Uri.parse(linkurl), headers: header);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = jsonDecode(response.body);
        print(responsebody);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
  
  Future<Either<StatusRequest, Map<String, dynamic>>> getdataasmap(
      String linkurl,  String Token) async {
    Map<String, String> header = {};
    header.addAll({"authorization": "token $Token"});
  
    if (await checkInternet()) {
      var response = await http.get(Uri.parse(linkurl), headers: header);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = jsonDecode(response.body);
        print(responsebody);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
