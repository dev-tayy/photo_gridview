import 'dart:io';
import 'package:dio/dio.dart';
import 'package:photo_view/utils/utils.dart';

class NetworkExceptions {
  static String getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return 'Request cancelled';
            case DioExceptionType.connectionTimeout:
              return 'Connection timed out!';
            case DioExceptionType.receiveTimeout:
              return 'Request timed out';
            case DioExceptionType.sendTimeout:
              return 'Request timed out';
            case DioExceptionType.connectionError:
              return 'You have no internet connection!';
            case DioExceptionType.badResponse:
              return error.message ?? 'An error occurred, try again!';
            case DioExceptionType.badCertificate:
              return ErrorTypes.generic.name;
            case DioExceptionType.unknown:
              return ErrorTypes.generic.name;
          }
        } else if (error is SocketException) {
          return 'You have no internet connection!';
        } else {
          return ErrorTypes.generic.name;
        }
      } on FormatException {
        return 'Bad response format';
      } catch (_) {
        return ErrorTypes.generic.name;
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return ErrorTypes.generic.name;
      } else {
        return ErrorTypes.generic.name;
      }
    }
  }
}
