import '../config/form_field_config.dart';

final AlbumForm=[
  const FormFieldConfig(
    name: "title",
    label: "Album Name",
    type: FieldType.text,
    required: true
  ),

  //  todo artist list

  //   todo album image

  const FormFieldConfig(
      name: "release_date",
      label: "Release Date",
      type: FieldType.text,
      required: true
  ),

  const FormFieldConfig(
      name: "description",
      label: "Description",
      type: FieldType.multiline,
  ),

];