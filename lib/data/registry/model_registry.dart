import 'package:basic_fundamental/data/data_model/MediaAssets.dart';
import 'package:basic_fundamental/module/page/modelEditPage/widgets/model_tile/media_tile.dart';

import '../../core/network/ApiEndpoint.dart';
import '../../module/page/modelEditPage/widgets/model_detail/album_details.dart';
import '../../module/page/modelEditPage/widgets/model_detail/artist_details.dart';
import '../../module/page/modelEditPage/widgets/model_detail/genre_details.dart';
import '../../module/page/modelEditPage/widgets/model_detail/song_details.dart';
import '../../module/page/modelEditPage/widgets/model_tile/album_tile.dart';
import '../../module/page/modelEditPage/widgets/model_tile/artist_tile.dart';
import '../../module/page/modelEditPage/widgets/model_tile/genre_tile.dart';
import '../../module/page/modelEditPage/widgets/model_tile/song_tile.dart';
import '../data_model/Artist.dart';
import '../data_model/album_module.dart';
import '../data_model/genre.dart';
import '../data_model/song_module.dart';
import 'model_definition.dart';
import 'model_type.dart';

class ModelRegistry {
  static final Map<ModelType, ModelDefinition> models = {
    ModelType.artist: ModelDefinition<Artist>(
      type: ModelType.artist,
      title: "Artist",
      api: ApiEndpoint.artist,
      fromJson: Artist.fromJson,
      tileBuilder: (item) => ArtistTile(
        artist: item,
      ),
    ),
    ModelType.genre: ModelDefinition<Genre>(
      type: ModelType.genre,
      title: "Genre",
      api: ApiEndpoint.genre,
      fromJson: Genre.fromJson,
      tileBuilder: (item) => GenreTile(
        genre: item,
      ),
    ),
    ModelType.album: ModelDefinition<Album>(
      type: ModelType.album,
      title: "Album",
      api: ApiEndpoint.get_album_song,
      fromJson: Album.fromJson,
      tileBuilder: (item) => AlbumTile(
        album: item,
      ),
    ),
    ModelType.song: ModelDefinition<Song>(
      type: ModelType.song,
      title: "Song",
      api: ApiEndpoint.get_song,
      fromJson: Song.fromJson,
      tileBuilder: (item) => SongTile(
        song: item,
      ),
    ),
    ModelType.mediaAssets: ModelDefinition<MediaAssets>(
        type: ModelType.mediaAssets,
        api: ApiEndpoint.Media_assets,
        title: "MediaAssets",
        fromJson: MediaAssets.fromJson,
        tileBuilder: (item) => Media_tile(mediaAssets: item))
  };

  static final Map<ModelType, ModelDetailDefinition> modelsDetails = {
    ModelType.artist: ModelDetailDefinition<Artist>(
      type: ModelType.artist,
      title: "Artist",
      apiBuilder: (artist) => ApiEndpoint.get_artist_song(
        artist.id!,
      ),
      fromJson: Artist.fromJson,
      DetailBuilder: (item) => ArtistDetail(artist: item),
    ),
    ModelType.genre: ModelDetailDefinition<Genre>(
      type: ModelType.genre,
      title: "Genre",
      apiBuilder: (genre) => ApiEndpoint.get_genre(
        genre.id!,
      ),
      fromJson: Genre.fromJson,
      DetailBuilder: (item) => GenreDetails(genre: item),
    ),
    ModelType.album: ModelDetailDefinition<Album>(
      type: ModelType.album,
      title: "Album",
      apiBuilder: (album) => ApiEndpoint.get_user_pick_album_song(
        album.id!,
      ),
      fromJson: Album.fromJson,
      DetailBuilder: (item) => AlbumDetail(album: item),
    ),
    ModelType.song: ModelDetailDefinition<Song>(
      type: ModelType.song,
      title: "Song",
      apiBuilder: (song) => ApiEndpoint.get_modity_current_song_id(
        song.id!,
      ),
      fromJson: Song.fromJson,
      DetailBuilder: (item) => SongDetails(song: item),
    ),
  };
}
