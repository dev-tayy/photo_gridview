import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_view/utils/exceptions.dart';
import 'package:photo_view/data/photo.datasource.dart';
import 'package:photo_view/data/photo.model.dart';
import 'package:photo_view/data/photo.repository.dart';
import 'package:photo_view/utils/utils.dart';

typedef AsyncEither<T> = Future<Either<String, T>>;

class MockPhotoDatasource extends Mock implements PhotoDatasource {}

class MockHiveService<T> extends Mock implements HiveService<T> {}

void main() {
  late PhotoRepository photoRepository;
  late MockPhotoDatasource mockPhotoDatasource;
  late MockHiveService<List> mockHiveService;

  setUp(() {
    mockPhotoDatasource = MockPhotoDatasource();
    mockHiveService = MockHiveService<List>();
    photoRepository = PhotoRepository(mockPhotoDatasource, mockHiveService);
  });

  test('fetchAllPhotos - Success', () async {
    // Arrange
    const page = 1;
    const perPage = 10;
    const response = ([], 100);
    final photos = response.$1.map((e) => PhotoModel.fromJson(e)).toList();

    when(() => mockPhotoDatasource.fetchAllPhotos(page: page, perPage: perPage))
        .thenAnswer((_) async => response);
    when(() => mockHiveService.put(
          box: DbKeys.photodb.name,
          collection: DbKeys.photodb.collection,
          data: any(named: 'data'),
        )).thenAnswer((_) async => _);

    // Act
    final result = await photoRepository.fetchAllPhotos(
      page: page,
      perPage: perPage,
    );

    // Assert
    expect(result.isRight(), true);
    expect(result.getOrElse(() => throw '').$1, photos);
    expect(result.getOrElse(() => throw '').$2, response.$2);
    verify(() =>
            mockPhotoDatasource.fetchAllPhotos(page: page, perPage: perPage))
        .called(1);
    verify(() => mockHiveService.put(
          box: DbKeys.photodb.name,
          collection: DbKeys.photodb.collection,
          data: photos,
        )).called(1);
  });

  test('fetchAllPhotos - DioException', () async {
    // Arrange
    const page = 1;
    const perPage = 10;
    var error = DioException(
      requestOptions: RequestOptions(path: '/photos'),
      response: Response(
        statusCode: 500,
        requestOptions: RequestOptions(path: '/photos'),
      ),
    );

    when(() => mockPhotoDatasource.fetchAllPhotos(page: page, perPage: perPage))
        .thenThrow(error);

    // Act
    final result = await photoRepository.fetchAllPhotos(
      page: page,
      perPage: perPage,
    );

    // Assert
    expect(result.isLeft(), true);
    expect(result.swap().getOrElse(() => ''),
        NetworkExceptions.getDioException(error));
    verify(() =>
            mockPhotoDatasource.fetchAllPhotos(page: page, perPage: perPage))
        .called(1);
    verifyNever(() => mockHiveService.put(
          box: DbKeys.photodb.name,
          collection: DbKeys.photodb.collection,
          data: any(named: 'data'),
        ));
  });

  test('fetchAllPhotos - Generic Exception', () async {
    // Arrange
    const page = 1;
    const perPage = 10;
    const error = 'Failed to fetch photos';

    when(() => mockPhotoDatasource.fetchAllPhotos(page: page, perPage: perPage))
        .thenThrow(Exception(error));

    // Act
    final result = await photoRepository.fetchAllPhotos(
      page: page,
      perPage: perPage,
    );

    // Assert
    expect(result.isLeft(), true);
    expect(result.swap().getOrElse(() => ''), ErrorTypes.generic.name);
    verify(() =>
            mockPhotoDatasource.fetchAllPhotos(page: page, perPage: perPage))
        .called(1);
    verifyNever(() => mockHiveService.put(
          box: DbKeys.photodb.name,
          collection: DbKeys.photodb.collection,
          data: any(named: 'data'),
        ));
  });
}
