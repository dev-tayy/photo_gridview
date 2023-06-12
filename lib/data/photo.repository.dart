import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:photo_view/data/photo.datasource.dart';
import 'package:photo_view/utils/exceptions.dart';
import 'package:photo_view/data/photo.model.dart';
import 'package:photo_view/utils/utils.dart';

typedef AsyncEither<T> = Future<Either<String, T>>;

class PhotoRepository {
  const PhotoRepository(this.photo, this.photoHive);
  final PhotoDatasource photo;
  final HiveService<List> photoHive;

  AsyncEither<(List<PhotoModel>, int)> fetchAllPhotos({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await photo.fetchAllPhotos(page: page, perPage: perPage);
      final photos = (response.$1).map((e) => PhotoModel.fromJson(e)).toList();
      await photoHive.put(
        box: DbKeys.photodb.name,
        collection: DbKeys.photodb.collection,
        data: photos,
      );
      return Right((photos, response.$2));
    } on DioException catch (e) {
      return Left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return Left(ErrorTypes.generic.name);
    }
  }
}
