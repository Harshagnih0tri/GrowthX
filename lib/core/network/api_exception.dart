import 'package:dio/dio.dart';

class ApiException {
  ApiException._();

  static String fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timed out. Please try again.";

      case DioExceptionType.sendTimeout:
        return "Request timeout. Please try again.";

      case DioExceptionType.receiveTimeout:
        return "Server took too long to respond.";

      case DioExceptionType.badCertificate:
        return "Invalid server certificate.";

      case DioExceptionType.badResponse:
        return _handleStatusCode(
          e.response?.statusCode,
          e.response?.data,
        );

      case DioExceptionType.cancel:
        return "Request cancelled.";

      case DioExceptionType.connectionError:
        return "No internet connection.";

      case DioExceptionType.transformTimeout:
        return "Response processing timed out.";

      case DioExceptionType.unknown:
      default:
        return "Something went wrong. Please try again.";
    }
  }

  static String _handleStatusCode(
    int? statusCode,
    dynamic data,
  ) {
    if (data is Map<String, dynamic>) {
      final detail = data["detail"];

      if (detail is String && detail.isNotEmpty) {
        return detail;
      }
    }

    switch (statusCode) {
      case 400:
        return "Bad request.";

      case 401:
        return "Unauthorized. Please login again.";

      case 403:
        return "Access denied.";

      case 404:
        return "Resource not found.";

      case 409:
        return "Conflict occurred.";

      case 422:
        return "Validation failed.";

      case 500:
        return "Internal server error.";

      case 502:
        return "Bad gateway.";

      case 503:
        return "Service unavailable.";

      default:
        return "Unexpected server error.";
    }
  }
}