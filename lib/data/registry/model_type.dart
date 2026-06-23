enum ModelType {
  song,
  song_rud,
  artist,
  artist_rud,
  album,
  album_rud,
  playlist,
  genre,
  genre_rud,
  mediaAssets,
}


ModelType getModelType(
    String modelName,
    ) {
  switch (modelName) {
    case "Artist":
      return ModelType.artist;

    case "Album":
      return ModelType.album;

    case "Genre":
      return ModelType.genre;

    case "Songs":
      return ModelType.song;

    case "album_rud":
      return ModelType.album_rud;

    case "MediaAsset":
      return ModelType.mediaAssets;

    default:
      throw Exception(
        "Unknown model: $modelName",
      );
  }
}
