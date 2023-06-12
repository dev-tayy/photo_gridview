import 'package:photo_view/config.dart';
import 'package:photo_view/utils/api.client.dart';

class PhotoDatasource {
  const PhotoDatasource(this.client);
  final ApiClient client;

  Future<(List, int)> fetchAllPhotos(
      {required int page, required int perPage}) async {
    try {
      var params = <String, int>{'page': page, 'per_page': perPage};
      client.setHeader('Authorization', 'Client-ID ${Config.clientId}');
      final response = await client.get('/photos', params: params);
      final lastPage = response.headers.value('X-Total').toString();
      return (response.data as List, int.parse(lastPage));
    } catch (e) {
      rethrow;
    }
  }
}
