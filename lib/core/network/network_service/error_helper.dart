import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/network_service/exceptions.dart';

class ErrorHelper {
  static AppException handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return NetworkException('No internet connection');
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return NetworkException('Connection timed out');
      case DioExceptionType.badResponse:
        final errorData = e.response?.data as Map<String, dynamic>?;
        return ValidationException(errorData?['message'] ?? 'Unknown server error');
      default:
        return ServerException(message: 'Unexpected error occurred', response: e.response);
    }
  }
}
