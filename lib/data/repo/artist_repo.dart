import 'package:basic_fundamental/network/ApiEndpoint.dart';
import 'package:basic_fundamental/network/Dio_pri_client.dart';

import '../data_model/Artist.dart';

class Artist_crud {
  final dio = DioPrivateClient().dio;

  Future<List<Artist>> get_artist_list() async {
    final response = await dio.get(ApiEndpoint.artist);
    final List result = response.data;
    return result.map((artist) => Artist.fromJson(artist)).toList();
  }

// Future<Artist> get_artist_song(int ArtistId) async {
//   final response = await dio.get(ApiEndpoint.get_artist_song(ArtistId));
//   return Artist.fromJson(response.data);
// }
}
