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
    name: "artist_image",
    label: "Artist Image",
    type: FieldType.image,
  ),

  const FormFieldConfig(
    name: "country",
    label: "Country",
    type: FieldType.text,
  ),
];