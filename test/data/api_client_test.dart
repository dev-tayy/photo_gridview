// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_view/utils/api.client.dart';

import '../mocks.dart';
import '../utils.dart';

void main() {
  late Dio dio;
  late ApiClient apiClient;

  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApiClient class', () {
    setUpAll(() async {
      await loadPathProvider();
      await initializeDeps();
    });

    setUp(() {
      dio = MockDio();
      apiClient = ApiClient(dio);
    });

    test('DioMock is a valid instance of Dio', () {
      expect(dio, isInstanceOf<Dio>());
      expect(apiClient.dio, isInstanceOf<Dio>());
      expect(apiClient.dio, dio);
    });

    test('SET HEADER - should call delated method', () {
      apiClient = MockApiClient();
      when(() => apiClient.setHeader('Authorization', 'Bearer 12345'))
          .thenReturn(null);
      apiClient.setHeader('Authorization', 'Bearer 12345');
      verify(() => apiClient.setHeader('Authorization', 'Bearer 12345'))
          .called(1);
    });
    group('Request Methods - GET, POST, PUT, DELETE', () {
      test('GET REQUEST - should call delated method', () async {
        const url = '/test';
        final queryParameters = {'key': 'value'};
        final responseData = {'data': 'response'};
        final response = Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: url),
        );

        when(
          () => dio.get(
            url,
            queryParameters: queryParameters,
          ),
        ).thenAnswer((i) async => Future.value(response));

        final result = await apiClient.get(url, params: queryParameters);

        expect(result.data, responseData);
        expect(result.statusCode, 200);
      });

      group('Exceptions', () {
        test('should throw FormatException when response is in bad format',
            () async {
          const url = '/test';

          when(() => dio.get(url))
              .thenThrow(const FormatException('Bad response format 👎'));

          expect(
            apiClient.get(url),
            throwsA(
              isInstanceOf<FormatException>().having(
                (e) => e.message,
                'message',
                'Bad response format 👎',
              ),
            ),
          );
        });
        test('should throw DioError', () async {
          const url = '/test';
          final responseData = {'status': 'error'};
          final response = Response(
            data: responseData,
            statusCode: 400,
            requestOptions: RequestOptions(path: url),
          );

          when(() => dio.get(url)).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: url),
              response: response,
            ),
          );

          expect(
            apiClient.get(url),
            throwsA(isInstanceOf<DioException>()),
          );
        });
      });
    });
  });
}
