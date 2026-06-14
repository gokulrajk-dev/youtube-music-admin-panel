import '../config/form_field_config.dart';

final artistForm = [
  const FormFieldConfig(
    name: "artist_name",
    label: "Artist Name",
    type: FieldType.text,
    required: true,
  ),
  const FormFieldConfig(
    name: "artist_bio",
    label: "Biography",
    type: FieldType.multiline,
  ),
  const FormFieldConfig(
    name: "country",
    label: "Country",
    type: FieldType.text,
  ),
  const FormFieldConfig(
      name: "artist_image",
      label: "Artist image",
      type: FieldType.image,
      required: true),
];
