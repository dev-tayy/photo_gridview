import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_view/utils/api.client.dart';

class MockHive extends Mock implements HiveInterface {
  MockHive() {
    when(initFlutter).thenAnswer((i) async => Future.value());
    when(() => openBox(any())).thenAnswer((_) async => MockBox());
  }
}

class MockBox extends Mock implements Box {
  MockBox() {
    when(() => get(any)).thenReturn('value');
  }
}

class MockDio extends Mock implements Dio {
  MockDio() {
    options = BaseOptions(
      baseUrl: 'https://www.google.com.ng',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }
  @override
  late BaseOptions options;
}

class MockApiClient extends Mock implements ApiClient {
  MockApiClient() {
    // const url = '/test';
    // final data = {'key': 'value'};
    // final responseData = {'data': 'response'};
    // final response = Response(
    //   data: responseData,
    //   statusCode: 200,
    //   requestOptions: RequestOptions(path: url),
    // );

    // when(() => dio.post(any(), data: any(named: 'data')))
    //     .thenAnswer((i) async => Future.value(response));

    // when(() => dio.delete(url, data: data))
    //     .thenAnswer((i) async => Future.value(response));

    // when(() => dio.patch(url, data: data))
    //     .thenAnswer((i) async => Future.value(response));

    // when(
    //   () => dio.get(
    //     url,
    //     queryParameters: data,
    //   ),
    // ).thenAnswer((i) async => Future.value(response));

    // when(() => setHeader(any(), any())).thenReturn(null);
  }
}
