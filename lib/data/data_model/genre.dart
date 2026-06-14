import 'package:basic_fundamental/data/data_model/song_module.dart';

class Genre {
  final int id;
  final String? genreName;
  final String? description;
  final List<Song>? songs_genre;

  Genre( {
    required this.id,
    this.genreName,
    this.description,
    this.songs_genre,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      genreName: json['genre_name']?.toString(),
      description: json['description']?.toString(),
      songs_genre: (json['songs_genre'] as List?)?.map((songGenre)=>Song.fromJson(songGenre)).toList(),
    );
  }
}
