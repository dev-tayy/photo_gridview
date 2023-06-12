import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_view/config.dart';
import 'package:photo_view/utils/api.client.dart';
import 'package:photo_view/data/photo.datasource.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late PhotoDatasource photoDatasource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    photoDatasource = PhotoDatasource(mockApiClient);
  });

  test('fetchAllPhotos', () async {
    // Arrange
    const page = 1;
    const perPage = 10;

    final response = Response(
        data: [],
        statusCode: 200,
        requestOptions: RequestOptions(path: '/photos'),
        headers: Headers.fromMap({
          'X-Total': ['100']
        }));

    when(() => mockApiClient.setHeader('Authorization', any()))
        .thenReturn(null);
    when(() => mockApiClient.get('/photos', params: any(named: 'params')))
        .thenAnswer((_) async => response);

    // Act
    final result =
        await photoDatasource.fetchAllPhotos(page: page, perPage: perPage);

    // Assert
    expect(result.$1, isA<List>());
    expect(result.$2, 100);
    verify(() => mockApiClient.setHeader(
        'Authorization', 'Client-ID ${Config.clientId}')).called(1);
    verify(() => mockApiClient
        .get('/photos', params: {'page': page, 'per_page': perPage})).called(1);
  });
}
