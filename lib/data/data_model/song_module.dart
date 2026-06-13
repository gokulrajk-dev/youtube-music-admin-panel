import 'package:basic_fundamental/data/data_model/song_stream.dart';

import 'Artist.dart';
import 'album_module.dart';
import 'genre.dart';

class Song {
  // @override
  // String? get song_title => title;
  //
  // @override
  // // TODO: implement song_id
  // int get song_id => id;
  //
  //
  // @override
  // String? get subtitle => artist?.map((e) => e.artistName).join(',');
  //
  // @override
  // String? get image => coverImage;

  final int id;
  final String? title;
  final List<Artist>? artist;
  final List<Genre>? genre;
  final Album? album;
  final String? coverImage;
  final Duration? duration;
  final String? releaseDate;
  final String? lyrics;
  final String? language;
  final int? views;
  int? likesCount;
  final SongStream? stream;

  Song({
    required this.id,
    this.title,
    this.artist,
    this.genre,
    this.album,
    this.coverImage,
    this.duration,
    this.releaseDate,
    this.lyrics,
    this.language,
    this.views,
    this.likesCount,
    this.stream,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title']?.toString(),
      artist:
          (json['artist'] as List?)?.map((e) => Artist.fromJson(e)).toList(),
      genre: (json['genre'] as List?)?.map((e) => Genre.fromJson(e)).toList(),
      album: json['album'] != null ? Album.fromJson(json['album']) : null,
      coverImage: json['cover_image']?.toString(),
      duration:
          json['duration'] != null ? _parseDuration(json['duration']) : null,
      releaseDate: json['release_date']?.toString(),
      lyrics: json['lyrics']?.toString(),
      language: json['language']?.toString(),
      views: json['views'] ?? 0,
      likesCount: json['likes_count'] ?? 0,
      stream:
          json['stream'] != null ? SongStream.fromJson(json['stream']) : null,
    );
  }

  static Duration _parseDuration(String duration) {
    final part = duration.split(':');
    return Duration(
        hours: int.parse(part[0]),
        minutes: int.parse(part[1]),
        seconds: int.parse(part[2]));
  }
}
