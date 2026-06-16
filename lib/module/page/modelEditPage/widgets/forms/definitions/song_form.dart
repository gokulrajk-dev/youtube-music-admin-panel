import '../config/form_field_config.dart';

final songForm = [
  const FormFieldConfig(
    name: "title",
    label: "Song Name",
    type: FieldType.text,
    required: true,
  ),

  const FormFieldConfig(
    name: "lyrics",
    label: "Lyrics",
    type: FieldType.multiline,
  ),

  const FormFieldConfig(
    name: "language",
    label: "Language",
    type: FieldType.text,
    required: true
  ),

  const FormFieldConfig(
    name: "release_date",
    label: "Release Date",
    type: FieldType.date,
    required: true
  ),

  const FormFieldConfig(
    name: "artist_id",
    label: "Artist",
    type: FieldType.multipleArtistSelection,
    required: true
  ),

  const FormFieldConfig(
    name: "genre_id",
    label: "Genre",
    type: FieldType.multipleGenreSelection,
    required: true
  ),

  const FormFieldConfig(
    name: "album_id",
    label: "Album",
    type: FieldType.multipleAlbumSelection,
    required: true
  ),
  const FormFieldConfig(
      name: "cover_image",
      label: "Image",
      type: FieldType.image,
      required: true
  ),
];