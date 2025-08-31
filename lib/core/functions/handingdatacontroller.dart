

import '../classes/stutusconntection.dart';


StatusRequest handlingData(dynamic response) {
  if (response is StatusRequest) {
    return response;
  }

  try {
    int statusCode = response['status']; // أو حسب الـ API تبعك
    switch (statusCode) {
      case 200:
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
  } catch (e) {
    return StatusRequest.serverException;
  }
}
