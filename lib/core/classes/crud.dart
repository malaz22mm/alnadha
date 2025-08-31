import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:alnadha/core/classes/stutusconntection.dart';
import '../functions/checkinternet.dart';

class Crud {
  Future<Either<Map<String, dynamic>, Map>> postData({
    required String linkurl,
    data,
    token,
    header,
  }) async {
    Map<String, String> headers;
    if (header != null) {
      headers = header;
    } else {
      headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept-Language": "en",
      };
    }
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }

    if (await checkInternet()) {
      var response = await http.post(Uri.parse(linkurl), body: data, headers: headers);
      var body = jsonDecode(response.body);
      print(response.statusCode);
      print("===body:${body}");
      switch (response.statusCode) {
        case 200:
        case 201:
          return Right(body);

        case 400:
          return Left({"status": StatusRequest.badRequest, "message": body["message"] ?? "طلب غير صالح"});
        case 403:
          return Left({"status": StatusRequest.unauthorized, "message": body["message"] ?? "غير مصادق"});
        case 404:
          return Left({"status": StatusRequest.notFound, "message": body["message"] ?? "غير موجود"});
        case 422:
          return Left({"status": StatusRequest.validationExpired, "message": body["message"] ?? "رمز منتهي"});
        case 500:
          return Left({"status": StatusRequest.serverFailure, "message": body["message"] ?? "خطأ من السيرفر"});
        default:
          return Left({"status": StatusRequest.failure, "message": "مشكلة غير معروفة"});
      }
    } else {
      return Left({"status": StatusRequest.offlineFailure, "message": "لا يوجد اتصال بالإنترنت"});
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
      var status = handelStatusCode(response.statusCode);

      if (status == StatusRequest.success) {
        var responsebody = jsonDecode(response.body);
        print(responsebody);

        return Right(responsebody);
      } else {
        return  Left(status);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> getdataasmap(
      String linkurl,  String Token) async {
    Map<String, String> header = {};
    header.addAll({"authorization": "token $Token"});

    if (await checkInternet()) {
      var response = await http.get(Uri.parse(linkurl), headers: header);
      print(response.statusCode);
      var status = handelStatusCode(response.statusCode);

      if (status == StatusRequest.success) {
        var responsebody = jsonDecode(response.body);
        print(responsebody);

        return Right(responsebody);
      } else {
        return  Left(status);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }


  Future<Either<StatusRequest, Map<String, dynamic>>> putData({
    required String linkurl,
    required Map<String, String> data,
    String? token,
    Map<String, String>? header,
  }) async {
    Map<String, String> headers;
    if (header != null) {
      headers = header;
    } else {
      headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept-Language": "en",
      };
    }
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    if (await checkInternet()) {
      var response = await http.put(
        Uri.parse(linkurl),
        headers: headers,
        body: data,
      );
      var status = handelStatusCode(response.statusCode);

      if (status == StatusRequest.success) {
        var responsebody = jsonDecode(response.body);
        return Right(responsebody);
      } else {
        return  Left(status);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }
  StatusRequest handelStatusCode(int statusCode) {
    switch (statusCode) {
      case 200:
      case 201:
        return StatusRequest.success;
      case 400:
        return StatusRequest.badRequest;
      case 403:
        return StatusRequest.unauthorized;
      case 404:
        return StatusRequest.notFound;
      case 422:
        return StatusRequest.validationExpired;
      case 500:
        return StatusRequest.serverFailure;
      default:
        return StatusRequest.failure;
    }
  }

}
