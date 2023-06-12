import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_view/utils/api.client.dart';
import 'package:photo_view/data/photo.datasource.dart';
import 'package:photo_view/data/photo.model.dart';
import 'package:photo_view/data/photo.repository.dart';
import 'package:photo_view/utils/utils.dart';

final GetIt getIt = GetIt.instance;

class AppManager {
  static Future<void> initializeDependencies() async {
    //initialize hive
    await Hive.initFlutter();

    Hive
      ..registerAdapter(PhotoModelAdapter())
      ..registerAdapter(UrlsAdapter())
      ..registerAdapter(UserAdapter())
      ..registerAdapter(SocialAdapter())
      ..registerAdapter(ProfileImageAdapter());

    getIt
      ..registerLazySingleton<Dio>(Dio.new)
      ..registerLazySingleton<ApiClient>(() => ApiClient(getIt()))

      //datasources
      ..registerLazySingleton<PhotoDatasource>(() => PhotoDatasource(getIt()))

      //repositories
      ..registerLazySingleton<PhotoRepository>(
        () => PhotoRepository(getIt(), getIt()),
      )
      ..registerSingletonAsync<HiveService<List>>(() async {
        final hiveService = HiveService<List>();
        await hiveService.open(DbKeys.photodb.name);
        return hiveService;
      });
  }
}
