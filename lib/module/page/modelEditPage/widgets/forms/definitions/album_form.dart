import '../config/form_field_config.dart';

final AlbumForm = [
  const FormFieldConfig(
      name: "title", label: "Album Name", type: FieldType.text, required: true),
  const FormFieldConfig(
      name: "description",
      label: "Description",
      type: FieldType.multiline,
      required: true),
  const FormFieldConfig(
    name: "release_date",
    label: "Release Date",
    type: FieldType.text,
  ),
  const FormFieldConfig(
      name: "artist_id",
      label: "artist id",
      type: FieldType.multipleSelection,
      required: true),
  const FormFieldConfig(
    name: "cover_image",
    label: "Album Image",
    type: FieldType.image,
  ),
];
