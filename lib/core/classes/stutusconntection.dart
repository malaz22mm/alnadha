enum StatusRequest {
  none,
  loading,
  success,
  failure,
  serverException,
  serverFailure,
  offlineFailure,

  // حالات حسب الكود
  badRequest,          // 400
  unauthorized,        // 403
  notFound,            // 404
  validationExpired,   // 422
}
