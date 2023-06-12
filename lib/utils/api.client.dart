import 'package:dio/dio.dart';
import 'package:photo_view/config.dart';

class ApiClient {
  ApiClient(this.dio) {
    dio.options.baseUrl = Config.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.headers.addAll(
      {
        'Accept': 'application/json',
        'Accept-Version': 'v1',
        'Content-Type': 'application/json',
      },
    );
  }
  final Dio dio;

  void setHeader(String key, String value) {
    dio.options.headers[key] = value;
  }

  Future<Response<dynamic>> get(
    String url, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: params);
      return response;
    } on FormatException {
      throw const FormatException('Bad response format 👎');
    } catch (e) {
      rethrow;
    }
  }
}
